using System;
using System.Security.Cryptography;
using System.Text;

namespace CRM_PROJECT
{
    
    public static class Helper
    {
        
        public static string Hash(string text)
        {
            if (text == null) text = "";

          
            string secret = "CRM@2026" + text;

            SHA256 sha = SHA256.Create();
            byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(secret));

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bytes.Length; i++)
                sb.Append(bytes[i].ToString("X2"));

            return sb.ToString();
        }
    }
}