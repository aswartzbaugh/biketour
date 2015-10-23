using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DOLUser
/// </summary>
public class DOLUser
{
	public DOLUser()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    private int userId;

    public int UserId
    {
        get { return userId; }
        set { userId = value; }
    }
    private int cityId;

    public int CityId
    {
        get { return cityId; }
        set { cityId = value; }
    }
    private int schoolId;

    public int SchoolId
    {
        get { return schoolId; }
        set { schoolId = value; }
    }
    private int classId;

    public int ClassId
    {
        get { return classId; }
        set { classId = value; }
    }
    private string firstName;

    public string FirstName
    {
        get { return firstName; }
        set { firstName = value; }
    }
    private string lastName;

    public string LastName
    {
        get { return lastName; }
        set { lastName = value; }
    }
    private string _userName;

    public string UserName
    {
        get { return _userName; }
        set { _userName = value; }
    }
    private string cityName;

    public string CityName
    {
        get { return cityName; }
        set { cityName = value; }
    }
    private string schoolName;

    public string SchoolName
    {
        get { return schoolName; }
        set { schoolName = value; }
    }
    private string className;

    public string ClassName
    {
        get { return className; }
        set { className = value; }
    }
    private string address;

    public string Address
    {
        get { return address; }
        set { address = value; }
    }
    private string email;

    public string Email
    {
        get { return email; }
        set { email = value; }
    }
    private string password;

    public string Password
    {
        get { return password; }
        set { password = value; }
    }
}