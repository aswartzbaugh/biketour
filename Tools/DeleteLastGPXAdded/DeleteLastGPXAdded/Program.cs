using Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeleteLastGPXAdded
{
    class Program
    {
        
        static void Main(string[] args)
        {
            try
            {
                // variable declaration
                BCStudent objStudent = new BCStudent();
                int studentId = 0;
                int UserRoleId = 5;
                int stagePlanId = 0;
                double stageDistance = 0;
                double distCovered = 0;
                Int32 UserId = 0;
                DataTable studInfo = null;

                string UserName = string.Empty;
                Int32 schoolId = 0;
                Int32 classId = 0;
                Int32 cityId = 0;
                // end variable declaration




                // Get student info
                StringBuilder sqlString = new StringBuilder();

                sqlString.Append("select * from LoginDtls where LoginName='");
                sqlString.Append(args[0]);
                sqlString.Append("' and cast(Password as varbinary(20))=cast('");
                sqlString.Append(args[1]);
                sqlString.Append("' as varbinary(50)) and IsActive=1");

                var login = DataAccessLayer.ReturnDataTable(sqlString.ToString());

                if (login != null)
                {
                    UserRoleId = Convert.ToInt32(login.Rows[0]["RoleId"]);
                    UserId = Convert.ToInt32(login.Rows[0]["LoginId"]);
                    UserName = Convert.ToString(login.Rows[0]["LoginName"]);

                    if (UserRoleId == 5)
                    {
                        sqlString = new StringBuilder();
                        sqlString.Append("Select * FROM StudentMaster Where LoginId = ");
                        sqlString.Append(UserId);

                        var student = DataAccessLayer.ReturnDataTable(sqlString.ToString());
                        if (student != null && student.Rows.Count > 0)
                        {
                            schoolId = Convert.ToInt32(student.Rows[0]["SchoolId"]);
                            classId = Convert.ToInt32(student.Rows[0]["ClassId"]);
                            cityId = Convert.ToInt32(student.Rows[0]["CityId"]);
                            studentId = Convert.ToInt32(student.Rows[0]["StudentId"]);
                        }
                    }

                    studInfo = objStudent.GetMyProfileInfo(studentId);
                    schoolId = Convert.ToInt32(studInfo.Rows[0]["SchoolId"]);
                    classId = Convert.ToInt32(studInfo.Rows[0]["ClassId"]);




                    DataSet _dtStage = objStudent.GetCurrentStageInfo((studentId > 0 ? studentId : UserId),
                        UserRoleId, classId);
                    if (_dtStage.Tables[0].Rows.Count > 0)
                    {
                        stagePlanId = Convert.ToInt32(_dtStage.Tables[0].Rows[0]["StagePlanId"]);
                        stageDistance = Convert.ToDouble(_dtStage.Tables[0].Rows[0]["Distance"]);
                        distCovered = double.Parse(_dtStage.Tables[0].Rows[0]["Distance_Covered"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                        //Convert.ToDouble(_dtStage.Tables[0].Rows[0]["Distance_Covered"]);
                    }

                    int res = objStudent.StudentsDeleteLastUpload(
                                           UserRoleId, UserId,
                                           0, studentId,
                                           stagePlanId, stageDistance, distCovered, classId, 1);

                }
                else
                    Console.WriteLine("Incorrect Username or Password");
            }
            catch (Exception ex)
            {
                Console.WriteLine("No last file found or internal server error occured, following are details : \n\n" + ex.Message);
            }
        }
    }
}
