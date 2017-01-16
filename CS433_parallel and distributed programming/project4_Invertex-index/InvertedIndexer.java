import java.io.IOException;import java.util.StringTokenizer;import org.apache.hadoop.conf.Configuration;import org.apache.hadoop.fs.Path;import org.apache.hadoop.io.IntWritable;import org.apache.hadoop.io.Text;import org.apache.hadoop.mapreduce.InputSplit;import org.apache.hadoop.mapreduce.Job;import org.apache.hadoop.mapreduce.Mapper;import org.apache.hadoop.mapreduce.Reducer;import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;import org.apache.hadoop.mapreduce.lib.input.FileSplit;import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;import org.apache.hadoop.util.GenericOptionsParser;public class InvertedIndexer {    public static class TokenizerMapper extends Mapper<Object, Text, Text, Text> {        private Text element = new Text();        private Text one = new Text();        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {            //get file path            InputSplit inputSplit = context.getInputSplit();            String fileName = ((FileSplit) inputSplit).getPath().toString();            //initial element            StringTokenizer itr = new StringTokenizer(value.toString());            while (itr.hasMoreTokens()) {                element.set(itr.nextToken() + ":" + fileName);                one.set("1");                context.write(element, one);            }        }    }    public static class SumCombiner extends Reducer<Text, Text, Text, Text> {        private Text result = new Text();        public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {            //sum up the frequency            int sum = 0;            for (Text val : values) {                sum += Integer.parseInt(val.toString());            }            //change unit format            int splitIndex = key.toString().indexOf(":");            result.set(key.toString().substring(splitIndex + 1) + ":" + sum);            key.set(key.toString().substring(0, splitIndex));            context.write(key, result);        }    }    public static class InvertedIndexReducer extends Reducer<Text, Text, Text, Text> {        private Text result = new Text();        @Override        protected void reduce(Text key, Iterable<Text> values, Reducer<Text, Text, Text, Text>.Context context)                throws IOException, InterruptedException {            //merge result            String fileList = new String();            for (Text value : values) {                fileList += value.toString() + ";";            }            result.set(fileList);            context.write(key, result);        }    }    public static void main(String[] args) throws Exception {        Configuration conf = new Configuration();        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();        if (otherArgs.length < 2) {            System.err.println("Usage: wordcount <in> [<in>...] <out>");            System.exit(2);        }        Job job = Job.getInstance(conf, "InvertedIndexer");        job.setJarByClass(InvertedIndexer.class);        job.setMapperClass(TokenizerMapper.class);        job.setCombinerClass(SumCombiner.class);        job.setReducerClass(InvertedIndexReducer.class);        job.setOutputKeyClass(Text.class);        job.setOutputValueClass(Text.class);        for (int i = 0; i < otherArgs.length - 1; ++i) {            FileInputFormat.addInputPath(job, new Path(otherArgs[i]));        }        FileOutputFormat.setOutputPath(job,                new Path(otherArgs[otherArgs.length - 1]));        System.exit(job.waitForCompletion(true) ? 0 : 1);    }}