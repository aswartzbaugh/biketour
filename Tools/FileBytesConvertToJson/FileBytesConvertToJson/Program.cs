using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using Newtonsoft.Json;

namespace FileBytesConvertToJson
{
    class Program
    {
        static void Main(string[] args)
        {
            if(args.Length == 2)
            {
                byte[] fileBytes = File.ReadAllBytes(args[0]);
                int[] fileBytesInIntForJsonConv = Array.ConvertAll<byte, int>(fileBytes, new Converter<byte,int>(ChangeToInt));
                File.WriteAllText(args[1], JsonConvert.SerializeObject(fileBytesInIntForJsonConv));
            }
        }

        private static int ChangeToInt(byte b)
        {
            return Convert.ToInt32(b);
        }
    }
}
