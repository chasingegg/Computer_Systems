// Compile with:
//     
//
// To specify the number of bodies in the world, the program optionally accepts
// an integer as its first command line argument.

#include <time.h>
#include <sys/times.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <X11/Xlib.h>
#include <unistd.h>
#include "omp.h"

#define WIDTH 1024
#define HEIGHT 768

// default number of bodies
#define DEF_NUM_BODIES 2000
// gravitational constant
#define GRAV 10.0
// initial velocities are scaled by this value
#define V_SCALAR 20.0
// initial masses are scaled by this value
#define M_SCALAR 5.0
// radius scalar
#define R_SCALAR 3
// coefficient of restitution determines the elasticity of a collision: C_REST = [0,1]
//  if C_REST = 0 -> perfectly inelastic (particles stick together)
//  if C_REST = 1 -> perfectly elastic (no loss of speed)
#define C_REST 0.5
// set the iteration times
#define iteration_times 100
// Must set 0 if run on Pi
#define NOT_RUN_ON_PI 1
#define TREERATIO 3

struct body {
    double x, y; // position
    double vx, vy; // velocity
    double ax, ay; //accelerate
    double m; // mass
    double r; // radius of the particle
};

struct world {
    struct body *bodies;
    int num_bodies;
};

clock_t total_time = 0;
//total_time.sec = 0;
//total_time.usec = 0;

double max (double a, double b)
{return (a > b ? a : b);}

double min (double a, double b)
{return (a < b ? a : b);}

struct node 
{
	struct body * bodyp;
	struct node * q1;
	struct node * q2;
	struct node * q3;
	struct node * q4;
	double totalmass;	
	double centerx, centery;
	double xmin, xmax;
	double ymin, ymax;
	double diag;
};

enum quadrant { q1, q2, q3, q4 };

enum quadrant getquadrant(double x, double y, double xmin, double xmax, double ymin, double ymax)
//makes a rectangle with bounds of xmin,xmax,ymin,ymax, and returns the quadrant that (x,y) is in
{
	double midx, midy;
	
	midx = xmin + 0.5*(xmax - xmin);
	midy = ymin + 0.5*(ymax - ymin);
	
	if(y > midy)
	{
		if(x > midx) return q1;
		else return q2;
	} 
	else {
		if(x > midx) return q4;
		else return q3;			
	}
}



struct node * createnode(struct body * bodyp, double xmin, double xmax, double ymin, double ymax)
//creates a leaf node to insert into the tree
{
	struct node * rootnode;
	if(!(rootnode=malloc(sizeof(struct node))))
	{
		printf("Unable to allocate node, exit");
		return 0;
	}
	
	rootnode->totalmass = bodyp->m;
	rootnode->centerx = bodyp->x;
	rootnode->centery = bodyp->y;
	rootnode->xmin = xmin;
	rootnode->xmax = xmax;
	rootnode->ymin = ymin;
	rootnode->ymax = ymax;
	rootnode->diag = sqrt(( pow(xmax - xmin, 2) + pow(ymax - ymin, 2) ));
		
	rootnode->bodyp = bodyp;
	rootnode->q1 = NULL;
	rootnode->q2 = NULL;
	rootnode->q3 = NULL;
	rootnode->q4 = NULL;

	return rootnode;
}

void updatecenterofmass(struct node * nodep, struct body * bodyp)
//updates the center of mass after inserting a point into a branch
{
	nodep->centerx = (nodep->totalmass*nodep->centerx + bodyp->m*bodyp->x)/(nodep->totalmass + bodyp->m);
	nodep->centery = (nodep->totalmass*nodep->centery + bodyp->m*bodyp->y)/(nodep->totalmass + bodyp->m);
	nodep->totalmass += bodyp->m;
	return;
}

void insertbody(struct body * insbody, struct node * nodep)
//inserts a body into the tree, converting leaf nodes into branches if necessary
{
	enum quadrant existingquad, newquad;
	double xmid, ymid;
	
	xmid = nodep->xmin + 0.5*(nodep->xmax - nodep->xmin);
	ymid = nodep->ymin + 0.5*(nodep->ymax - nodep->ymin);
		
	if(nodep->bodyp != NULL) //if the node is a leaf convert to a branch by inserting the leaf point into one of its subquadrants
	{
		existingquad = getquadrant(nodep->bodyp->x, nodep->bodyp->y, nodep->xmin, nodep->xmax, nodep->ymin, nodep->ymax);
			
		switch (existingquad)
		{
			case q1:
				nodep->q1 = createnode(nodep->bodyp, xmid, nodep->xmax, ymid, nodep->ymax);
				break;
			case q2:
				nodep->q2 = createnode(nodep->bodyp, nodep->xmin, xmid, ymid, nodep->ymax);
				break;
			case q3:
				nodep->q3 = createnode(nodep->bodyp, nodep->xmin, xmid, nodep->ymin, ymid);
				break;
			case q4:
				nodep->q4 = createnode(nodep->bodyp, xmid, nodep->xmax, nodep->ymin, ymid);
				break;
		}
		nodep->bodyp = NULL;
	}
	
	newquad = getquadrant(insbody->x, insbody->y, nodep->xmin, nodep->xmax, nodep->ymin, nodep->ymax);
	
	updatecenterofmass(nodep,insbody);
	
	switch (newquad) //insert the new point into one of the quadrants if empty, otherwise recurse deeper into tree
	{
	case q1:
		if(nodep->q1 == NULL)
		{		
			nodep->q1 = createnode(insbody, xmid, nodep->xmax, ymid, nodep->ymax);		
		} else {
			insertbody(insbody,nodep->q1);
		}
		break;
	case q2:
		if(nodep->q2 == NULL)
		{			
			nodep->q2 = createnode(insbody, nodep->xmin, xmid, ymid, nodep->ymax);
		} else {			
			insertbody(insbody,nodep->q2);
		}
		break;
	case q3:
		if(nodep->q3 == NULL)
		{			
			nodep->q3 = createnode(insbody, nodep->xmin, xmid, nodep->ymin, ymid);
		} else {			
			insertbody(insbody,nodep->q3);
		}
		break;
	case q4:
		if(nodep->q4 == NULL)
		{			
			nodep->q4 = createnode(insbody, xmid, nodep->xmax, nodep->ymin, ymid);
		} else {			
			insertbody(insbody,nodep->q4);
		}
		break;
	}	
}

void treesum(struct node * nodep, struct body * bodyp, double ratiothreshold )
//sum the forces on body bodyp from points in tree with root node nodep
{
	double dx, dy, r, rsqr; //x distance, y distance, distance, distance^2
	double accel;
	double a_over_r;
		
	dx = nodep->centerx - bodyp->x;
	dy = nodep->centery - bodyp->y;
	
	rsqr = pow(dx,2) + pow(dy,2);
	r = sqrt(rsqr);
	if(r < 25){
	r = 25;	
	}
	if( (((r/nodep->diag) > ratiothreshold) || (nodep->bodyp))&&(nodep->bodyp!=bodyp) )
	{

		accel = (10.0) * nodep->totalmass / r/r/r;
		
		bodyp->ax += accel*dx;
		bodyp->ay += accel*dy;		
	
	} else {
		if(nodep->q1) { treesum(nodep->q1, bodyp, ratiothreshold); }
		if(nodep->q2) { treesum(nodep->q2, bodyp, ratiothreshold); }
		if(nodep->q3) { treesum(nodep->q3, bodyp, ratiothreshold); }
		if(nodep->q4) { treesum(nodep->q4, bodyp, ratiothreshold); }
	}
	return;
}

void destroytree(struct node * nodep)
{
	if(nodep != NULL)
	{
		if(nodep->q1 != NULL) 
		{ 
			destroytree(nodep->q1); 
		}
		if(nodep->q2 != NULL) 
		{ 
			destroytree(nodep->q2); 
		}
		if(nodep->q3 != NULL) 
		{ 
			destroytree(nodep->q3); 
		}
		if(nodep->q4 != NULL) 
		{ 
			destroytree(nodep->q4); 
		}
		free(nodep);
	}
}

/* This function initializes each particle's mass, velocity and position */
struct world* create_world(int num_bodies) {
    struct world *world = malloc(sizeof(struct world));

    world->num_bodies = num_bodies;
    world->bodies = malloc(sizeof(struct body)*num_bodies);

    int i = 0;
    double x;
    double y;
    double rc;

    int min_dim = (WIDTH < HEIGHT) ? WIDTH : HEIGHT;

    while (i<num_bodies) {
        x = drand48() * WIDTH;
        y = drand48() * HEIGHT;
        rc = sqrt((WIDTH/2-x)*(WIDTH/2-x) + (y-HEIGHT/2)*(y-HEIGHT/2));
        if (rc <= min_dim/2) {
            world->bodies[i].x = x;
            world->bodies[i].y = y;

            world->bodies[i].vx = V_SCALAR * (y-HEIGHT/2) / rc;
            world->bodies[i].vy = V_SCALAR * (WIDTH/2-x) / rc;
            world->bodies[i].ax = 0;
            world->bodies[i].ay = 0;
            world->bodies[i].m = (1 / (0.025 + drand48())) * M_SCALAR;
            world->bodies[i].r = sqrt(world->bodies[i].m / M_PI) * R_SCALAR;
            i++;
        }
    }
    return world;
}

// set the foreground color given RGB values between 0..255.
void set_color(Display *disp, GC gc, int r, int g, int b){
  unsigned long int p ;

  if (r < 0) r = 0; else if (r > 255) r = 255;
  if (g < 0) g = 0; else if (g > 255) g = 255;
  if (b < 0) b = 0; else if (b > 255) b = 255;

  p = (r << 16) | (g  << 8) | (b) ;

  XSetForeground(disp, gc, p) ;
}


/* This function updates the screen with the new positions of each particle */
void draw_world(Display *disp, Pixmap back_buf, GC gc, struct world *world) {
    int i;
    double x, y, r, r2;

    // we turn off aliasing for faster draws
    set_color(disp, gc, 255, 255, 255);
    XFillRectangle(disp, back_buf, gc, 0, 0, WIDTH, HEIGHT);

    for (i = 0; i < world->num_bodies; i++) {
        r = world->bodies[i].r;
        x = world->bodies[i].x - r;
        y = world->bodies[i].y - r;
        r2 = r + r;

        // draw body
        set_color(disp, gc, 255*7/10, 255*7/10, 255*7/10);
        XFillArc(disp, back_buf, gc, x, y, r2, r2, 0, 360*64); 
        set_color(disp, gc, 0, 0, 0);
        XDrawArc(disp, back_buf, gc, x, y, r2, r2, 0, 360*64); 
    }
}

void collision_step(struct world *world) {
    int a, b;
    double r, x, y, vx, vy;

    // Impose screen boundaries by reversing direction if body is off screen
    for (a = 0; a < world->num_bodies; a++) {
        r = world->bodies[a].r;
        x = world->bodies[a].x;
        y = world->bodies[a].y;
        vx = world->bodies[a].vx;
        vy = world->bodies[a].vy;

        if (x-r < 0) { // left edge
            if (vx < 0) { world->bodies[a].vx = -C_REST * vx; }
            world->bodies[a].x = r;
        } else if (x+r > WIDTH) { // right edge
            if (vx > 0) { world->bodies[a].vx = -C_REST * vx; }
            world->bodies[a].x = WIDTH - r;
        }

        if (y-r < 0) { // bottom edge
            if (vy < 0) { world->bodies[a].vy = -C_REST * vy; }
            world->bodies[a].y = r;
        } else if (y+r > HEIGHT) { // top edge
            if (vy > 0) { world->bodies[a].vy = -C_REST * vy; }
            world->bodies[a].y = HEIGHT - r;
        }
    }
}




void position_step(struct world *world, double time_res){
    struct node * rootnode;
    
    //struct body * bodies = world->bodies;
    //int nbodies = world->num_bodies;
    double xmin, xmax, ymin, ymax;
	
	xmin = 0.0;
	xmax = 0.0;
	ymin = 0.0;
	ymax = 0.0;
		
	for(int i = 0; i < world->num_bodies; i++)  //reset accel
	{
		world->bodies[i].ax = 0.0;
		world->bodies[i].ay = 0.0;	
		xmin=min(xmin,world->bodies[i].x);
		xmax=max(xmax,world->bodies[i].x);
		ymin=min(ymin,world->bodies[i].y);
		ymax=max(ymax,world->bodies[i].y);
	}
	
	rootnode = createnode(world->bodies+0,xmin,xmax,ymin,ymax);
    //rootnode = createnode(bodies+0,0,WIDTH,0,HEIGHT);
    for(int i = 1; i < world->num_bodies; i++)
	{
		insertbody(world->bodies+i, rootnode);
	}
#pragma omp parallel
{
    #pragma omp for
    for(int i = 0; i < world->num_bodies; i++)  //sum accel
	{
		treesum(rootnode, world->bodies+i, TREERATIO);
	}

    #pragma omp for
    for(int i = 0; i < world->num_bodies; i++)
	{	
        //Update velocities		
		world->bodies[i].vx += world->bodies[i].ax * time_res; 
		world->bodies[i].vy += world->bodies[i].ay * time_res;
        
        //Update positions
		world->bodies[i].x += world->bodies[i].vx * time_res; 
		world->bodies[i].y += world->bodies[i].vy * time_res;
	} 
}
    destroytree(rootnode);		
}

void step_world(struct world *world, double time_res) {
	
	struct tms ttt;
	clock_t start, end;
	start = times(&ttt);
    position_step(world, time_res);
	end = times(&ttt);
	total_time += end - start;

    collision_step(world);
}


/* Main method runs initialize() and update() */
int main(int argc, char **argv) {
	//total_time.tv_sec = 0;
	//total_time.tv_usec = 0;
    /* get num bodies from the command line */
    int num_bodies;
    num_bodies = (argc == 2) ? atoi(argv[1]) : DEF_NUM_BODIES;
    printf("Universe has %d bodies.\n", num_bodies);
    omp_set_num_threads(8);
    /* set up the universe */
    time_t cur_time;
    time(&cur_time);
    srand48((long)cur_time); // seed the RNG used in create_world
    struct world *world = create_world(num_bodies);
	
    /* set up graphics using Xlib */
#if NOT_RUN_ON_PI
    Display *disp = XOpenDisplay(NULL);
    int scr = DefaultScreen(disp);
    Window win = XCreateSimpleWindow(
            disp,
            RootWindow(disp, scr),
            0, 0,
            WIDTH, HEIGHT,
            0,
            BlackPixel(disp, scr), WhitePixel(disp, scr));
    XStoreName(disp, win, "N-Body Simulator");

    Pixmap back_buf = XCreatePixmap(disp, RootWindow(disp, scr),
            WIDTH, HEIGHT, DefaultDepth(disp, scr));
    GC gc = XCreateGC(disp, back_buf, 0, 0);

    // Make sure we're only looking for messages about closing the window
    Atom del_window = XInternAtom(disp, "WM_DELETE_WINDOW", 0);
    XSetWMProtocols(disp, win, &del_window, 1);

    XSelectInput(disp, win, StructureNotifyMask);
    XMapWindow(disp, win);
    XEvent event;
    // wait until window is mapped
    while (1) {
        XNextEvent(disp, &event);
        if (event.type == MapNotify) {
            break;
        }
    }
#endif

    struct timespec delay={0, 1000000000 / 60}; // for 60 FPS
    struct timespec remaining;
	double delta_t = 0.1;
	int ii;
	
    for(ii = 0; ii < iteration_times; ii++){
        // check if the window has been closed
#if NOT_RUN_ON_PI	
        if (XCheckTypedEvent(disp, ClientMessage, &event)) {
            break;
        }

        // we first draw to the back buffer then copy it to the front (`win`)
        draw_world(disp, back_buf, gc, world);
        XCopyArea(disp, back_buf, win, gc, 0, 0, WIDTH, HEIGHT, 0, 0);
#endif

        step_world(world, delta_t);

		//if you want to watch the process in 60 FPS
        //nanosleep(&delay, &remaining);
    }

//	printf("Total Time = %f\n", (double)total_time.tv_sec + (double)total_time.tv_usec/1000000);
	printf("Nbody Position Calculation Time = :%lf s\n",(double)total_time / (sysconf(_SC_CLK_TCK)));

#if NOT_RUN_ON_PI	
    XFreeGC(disp, gc);
    XFreePixmap(disp, back_buf);
    XDestroyWindow(disp, win);
    XCloseDisplay(disp);
#endif

    return 0;
}
