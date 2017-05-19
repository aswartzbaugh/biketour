alter table StudentUpload add IsKmAddManual bit null default 0;  

USE [BikeTour]
GO

/****** Object:  StoredProcedure [dbo].[SP_INSERT_STUDENTUPLOADS]    Script Date: 5/19/2017 7:30:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
/*      
exec SP_INSERT_STUDENTUPLOADS 0,956,1025,39.0,10.0,0,'','','11.07.2017 19:40:01', 10.0, 5.4486111111111075,81,0,5,956,0,1,0
*/      
ALTER PROCEDURE [dbo].[SP_INSERT_STUDENTUPLOADS]              
(              
 @StudentUploadId int,              
 @StudentId int,        
 @StagePlanId int,        
 @StagePlanDistance float,        
 @DistanceCovered float,        
 @CalculateDistance float,        
 @FilePath varchar(100),        
 @FileName varchar(100),        
 @Uploadeddate datetime,        
 @Kilometer float,        
 @Time float,        
 @ClassId int,        
 @IsValid bit,       
 @RoleId int=null,    
 @UserId int = null,   
 @TrackCount INT = 0,   
 @IsKmAddManual bit = 0,
 @result int output        
)              
As               
begin        
 set @result = 0        
 if(@StudentUploadId = 0)        
 if(@StudentId = 0) begin set @StudentId=null end        
 begin        
  if exists(select 1 from StudentUpload where (FilePath = @FilePath and IsKmAddManual = 0) 
  or ((Kilometer=@Kilometer and Time=@Time) and ClassId=@ClassId and IsKmAddManual <> 1))        
  begin        
   print 'exist'        
   set @result = 0        
  end         
  else        
  begin        
   print 'insert'        
   insert into StudentUpload        
   (        
    StudentId,        
    ClassId,        
    StagePlanId,        
    FilePath,        
    FileName,        
    Uploadeddate,        
    Kilometer,        
    Time,        
    IsValid,    
    RoleId,    
    UserId,  
    TrackPointCount,
	IsKmAddManual      
   )        
   values        
   (        
    @StudentId,        
    @ClassId,        
    (case @StagePlanId when 0 then NULL else @StagePlanId end),        
    @FilePath,        
    @FileName,        
    @Uploadeddate,        
    @Kilometer,        
    @Time,        
    (case @IsValid when 0 then NULL else 1 end),            
    @RoleId,    
    @UserId,  
    @TrackCount,
	@IsKmAddManual        
   )        
           
   -- Update Stage plan distance_covered        
   declare @CountCompleteLeg int, @CountTestPassed int, @TestForCity int        
   set @CountCompleteLeg=(select COUNT(*) from StagePlan where ClassId=@ClassId         
      and StatusId=3 and IsActive=1)         
   print '@CountCompleteLeg:' + CONVERT(VARCHAR(50),@CountCompleteLeg)         
           
   set @CountTestPassed=(select COUNT(*) from QuizResult where IsPassed=1 and ClassId=@ClassId         
      and CityId=(select FromCityId from StagePlan where ClassId = @ClassId        
      and StagePlanId  =@StagePlanId) and IsDeleted=0)        
   print '@CountTestPassed:' + CONVERT(VARCHAR(50),@CountTestPassed)          
           
   set @TestForCity=(select COUNT(*) from QuizResult where IsPassed=1 and ClassId=@ClassId         
      and CityId=(select ToCityId from StagePlan where ClassId = @ClassId        
      and StagePlanId=@StagePlanId) and IsDeleted=0)        
   print '@TestForCity:' + CONVERT(VARCHAR(50),@TestForCity)        
           
   if(@CountCompleteLeg>0 and @CountTestPassed>0 and @TestForCity=0)        
   begin        
   print '1 if'        
    if(@StagePlanDistance <>0) begin        
    set @CalculateDistance = @DistanceCovered + @Kilometer        
    if(@CalculateDistance > @StagePlanDistance) begin        
     set @CalculateDistance=@CalculateDistance-@StagePlanDistance        
     update StagePlan set        
     Distance_Covered = @StagePlanDistance,        
     Distance_Extra=@CalculateDistance        
     where ClassId = @ClassId        
     and StagePlanId  =@StagePlanId        
     set @result = @StagePlanId        
    end        
    else         
    begin        
     print '1 if - else'        
     update StagePlan set        
     Distance_Covered = @CalculateDistance        
     where ClassId = @ClassId        
     and StagePlanId  =@StagePlanId        
     set @result = @StagePlanId        
    end        
    end        
   end        
   else if(@CountCompleteLeg>0 and @CountTestPassed=0)        
   begin        
   print '2 if'        
    set @StagePlanId=(select max(StagePlanId) from StagePlan Where ClassId=@ClassId and StatusId=3 and IsActive=1)        
    update StagePlan        
    set Distance_Extra=Distance_Extra+@Kilometer        
    where StagePlanId=@StagePlanId        
    set @result = @StagePlanId        
   end        
   else        
   begin        
    ----------        
    print '3 if'        
    if(@StagePlanDistance <>0) begin        
    set @CalculateDistance = @DistanceCovered + @Kilometer        
    if(@CalculateDistance > @StagePlanDistance) begin        
    print '3 if - 1'        
     set @CalculateDistance=@CalculateDistance-@StagePlanDistance        
     update StagePlan set        
     Distance_Covered = @StagePlanDistance,        
     Distance_Extra=@CalculateDistance        
     where ClassId = @ClassId        
     and StagePlanId  =@StagePlanId        
             
     if exists(select 1 from QuizResult where IsPassed=1 and ClassId=@ClassId         
      and CityId=(select FromCityId from StagePlan where ClassId = @ClassId        
      and StagePlanId  =@StagePlanId) and IsDeleted=0)        
      begin        
      print '3 if - 2'        
       if exists(select 1 from StagePlan where ClassId=@ClassId and StatusId=1 and IsActive=1)        
       begin        
        -- Update new stage leg        
        update StagePlan         
        set Distance_Covered = @CalculateDistance         
        where StagePlanId= (select min(StagePlanId) from StagePlan         
             where ClassId=@ClassId and StatusId=1 and IsActive=1)        
                 
        -- Update existing leg        
        update StagePlan set        
        Distance_Extra=0        
        where ClassId = @ClassId        
        and StagePlanId  =@StagePlanId        
       end        
      end        
    end        
    else        
    begin        
     update StagePlan set        
     Distance_Covered = Distance_Covered + @Kilometer        
     where ClassId = @ClassId        
     and StagePlanId  =@StagePlanId        
    end        
   end        
           
   set @result = @@IDENTITY        
   -----        
  end        
           
           
  end        
 end        
   --Waseem: if Distance= Distance_Covered then set stage plan to is active=false
	--begin       
	--	if ((select COUNT(*) from StagePlan where Distance=Distance_Covered and StagePlanId=@StagePlanId)>0)
	--	 update StagePlan set  IsActive=0 where StagePlanId=@StagePlanId
	--end
	--Waseem: if Distance= Distance_Covered then set stage plan to is active=false     
	print 'Result: ' + CONVERT(VARCHAR(50),@result)  ;
 return @result        
end 

GO


