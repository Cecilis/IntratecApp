using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

namespace IntraTecApp
{
    public class cAjustarTiempo
    {
        public static DateTime GetAdjustedTime(DateTime timeInput)
        {
            return timeInput.AddHours(cAjustarTiempo.CalculateOffset(timeInput));
        }

        public static DateTime GetReverseAdjustedTime(DateTime timeInput)
        {
            return timeInput.AddHours(-cAjustarTiempo.CalculateOffset(timeInput));
        }

        public static double CalculateOffset(DateTime timeInput)
        {
            bool isDST = Convert.ToBoolean(ConfigurationManager.AppSettings["Dia"]);
            double offset = Convert.ToDouble(ConfigurationManager.AppSettings["Offset"]);
            if ((offset < -4) && (offset > -11))
            {
                // us dst
                DateTime startDate = new DateTime(timeInput.Year, 4, Convert.ToInt32((2 + (6 * timeInput.Year) - Math.Floor((double)timeInput.Year / 4)) % 7) + 1, 2, 0, 0);
                DateTime endDate = new DateTime(timeInput.Year, 10, Convert.ToInt32(31 - (Math.Floor((double)timeInput.Year * 5 / 4) + 1) % 7), 2, 0, 0);
                if ((timeInput > startDate) && (timeInput < endDate)) isDST = true;
            }
            if ((offset > -1) && (offset < 5))
            {
                // european dst
                DateTime startDate = new DateTime(timeInput.Year, 3, Convert.ToInt32(31 - (Math.Floor((double)timeInput.Year * 5 / 4) + 1) % 7), 1, 0, 0);
                DateTime endDate = new DateTime(timeInput.Year, 10, Convert.ToInt32(31 - (Math.Floor((double)timeInput.Year * 5 / 4) + 1) % 7), 1, 0, 0);
                if ((timeInput > startDate) && (timeInput < endDate)) isDST = true;
            }
            if (isDST) offset++;
            return offset;
        }
    }


}