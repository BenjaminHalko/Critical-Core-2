
if(async_load[?"status"] != 1)// 1==downloading, 0==success ,<0==Error
if(async_load[?"id"] == request)
{   
	alarm[0] = refreshCall
	
    if(async_load[?"http_status"] == 200)
    {
		countError = 0
        if(firstTime or async_load[?"result"] != cache)
        {
            firstTime = false
            cache = async_load[?"result"]
			FirebaseREST_HTTP_Success_RealTime()
        }
    }
	else
	{
		if(async_load[?"http_status"] == 401)//if i not have permissions, destroy me
		{
			FirebaseREST_HTTP_Failed_RealTime()
			instance_destroy()
			exit
		}
		
		if(firstTime or async_load[?"result"] != cache)
		{
		    alarm[0] = errorResetAlarm
		    countError++
		    if(countError >= errorCountLimit)
			{
				cache = async_load[?"result"]
				firstTime = false
				countError = 0
		        FirebaseREST_HTTP_Failed_RealTime()
		    }
		}
	}
}
 
