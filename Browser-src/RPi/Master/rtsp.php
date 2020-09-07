<html>
<head><title>HealthKeeper -  Master - Video Camera</title>
</head>
<body>

<?php

{



    echo "<h1> FogBus Master - Camera </h1>";

    
    if(strlen($_GET['addr']) > 0){
        $fRtspConnected = fopen("rtspConnected", "r"); 
        $rstpConnected = fgets($fRtspConnected);


        $fRtsp = fopen("rtsp", "r"); 
        $rstp = fgets($fRtsp);

        file_put_contents("rtspConnected", 0);
        while(fgets($fRtspConnected) != 0);
        file_put_contents("rtsp", $_GET['addr']);


        for ($x = 0; $x <= 10; $x++) {
            sleep(1);
            if (1 == fgets($fRtspConnected )){
                break;
            }
        }

    }

    if(strlen($_GET['disconnect']) > 0){
        $fRtspConnected = fopen("rtspConnected", "r"); 
        $rstpConnected = fgets($fRtspConnected);
        file_put_contents("rtspConnected", 0);
        file_put_contents("rtsp", "");
    
        for ($x = 0; $x <= 10; $x++) {
            sleep(1);
            if (rstpConnected != fgets($fRtspConnected)){
                break;
            }
        }
    }

    $file = fopen("rtsp", "r");
    $addr = fgets($file);

    $fRtspConnected = fopen("rtspConnected", "r"); 
    $rstpConnected = fgets($fRtspConnected);
  
    
    if($rstpConnected == 1){
        echo "Master has connectted to: $addr <br>";
        echo "<form id='disconnect' action='rtsp.php' method='get' accept-charset='UTF-8'>
        <br>
        <input type='submit' name='disconnect' value='Disconnect' />
        </fieldset>
        </form>";
    }else{
        if (strlen($addr) < 2) {
            echo "No device connects to Master, please provide camera addr below: <br>";
        }else{
            echo "The addr provided is not available: $addr <br> <br>
            Please provide camera addr below: <br>";
        }
        
        echo "<form id='disconnect' action='rtsp.php' method='get' accept-charset='UTF-8'>
        <br>
        <input type='text' name='addr' id='addr'  maxlength=\"500\" /> 
        <br> <br>
        <input type='submit' name='connect' value='connect' />
        </fieldset>
        </form>";
    }


}


?>
</body>
</html>
<!-- rtsp://camera:pw12345678@192.168.88.227:554/Streaming/Channels/101 -->