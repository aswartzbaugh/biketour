<?php

	//$version = $_POST['v'];
	$points = $_GET['sp'];
	//$passing_percent = $_POST['psp'];
	//$gained_score = $_POST['tp'];
	//$username = $_POST['sn'];
	//$email = $_POST['se'];
	//$quiz_title = $_POST['qt'];

	$points_num = (int)$points;
	//$passing_num = ((int)$passing_percent)/100 * (int)$gained_score;
	
	$f = fopen("result.txt", "w") or die("Error opening file 'result.txt' for writing");
	
	fwrite($f, "--------------------------\n");
	fwrite($f, "User name: ".$username."\n");
	fwrite($f, "User email: ".$email."\n");
	fwrite($f, "Quiz title: ".$quiz_title."\n");
	fwrite($f, "Points awarded: ".$points."\n");
	fwrite($f, "Total score: ".$gained_score."\n");
	fwrite($f, "Passing score: ".$passing_num."\n");

  //if($points_num <=0)
	//  header('Location: http://tourdeeurope.eu/quiz.aspx?pscore=100&totalScore=100&pointsawarded=0');
  //else
	//  header('Location: http://tourdeeurope.eu/quiz.aspx?pscore=100&totalScore=100&pointsawarded=100');
    
  if($points_num <=0)
	  header('Location: http://stadt-land-rad.org/quiz.aspx?pscore=100&totalScore=100&pointsawarded=0');
  else
	  header('Location: http://stadt-land-rad.org/quiz.aspx?pscore=100&totalScore=100&pointsawarded=100');
   
	if ($points_num >= $passing_num)
	{
		fwrite($f, "User passes\n");
	}
	else
	{
		fwrite($f, "User fails\n");
	}
	
	fwrite($f, "--------------------------\n");	
	
	if($f) 
	{ 
		fclose($f); 
	}
?>
