#!/bin/sh
while [ true ]
do
	echo "Which instance's IP you wanna update (1 or 2):"
	read one
	if [[ "$one" -eq 1 || "$one" -eq 2 ]]
	then
		while [ true ]
		do
			echo "Do you wanna make change for anpr or vf (case sensitive):"
			read input
			echo $input
			if [[ "$input" -eq "anpr" ]]
			then
				echo Enter the Previous anpr camera username:
				read anpr_us
				echo $anpr_us
				echo Enter the Previous anpr camera password:
				read anpr_ps
				echo Enter the Previous anpr camera IP:
				read anpr_ip
        			echo Enter the new anpr camera username:
        			read new_us
        			echo Enter the new anpr camera password:
        			read new_ps
        			echo Enter the new anpr camera IP:
        			read new_ip
				sudo sed -i s/"$anpr_us"/"$new_us"/ /uncanny/anpr/instance$one/config/config.json 2>&1
				sudo sed -i s/"$anpr_ps"/"$new_ps"/ /uncanny/anpr/instance$one/config/config.json 2>&1
				sudo sed -i s/"$anpr_ip"/"$new_ip"/ /uncanny/anpr/instance$one/config/config.json 2>&1
				cat /uncanny/anpr/instance1/config/config.json | grep rtsp
			elif [[ "$input" -eq "vf" ]]
			then
        			echo Enter the Previous vf camera username:
        			read vf_us
        			echo Enter the Previous vf camera password:
        			read vf_ps
        			echo Enter the Previous vf camera IP:
        			read vf_ip
        			echo Enter the new vf camera username:
        			read vf_us
        			echo Enter the new vf camera password:
        			read vf_ps
        			echo Enter the new vf camera IP:
        			read vf_ip
        			sudo sed -i s/"$vf_us"/"$new_us"/ /uncanny/anpr/instance$one/config/config.json 2>&1
        			sudo sed -i s/"$vf_ps"/"$new_ps"/ /uncanny/anpr/instance$one/config/config.json 2>&1
        			sudo sed -i s/"$vf_ip"/"$new_ip"/ /uncanny/anpr/instance$one/config/config.json 2>&1
        			cat /uncanny/anpr/instance1/config/config.json | grep rtsp
			else
				echo "Please give the proper input"
			fi
			echo "Do you want to continue with other camera in instance$one ?"
			read no
			if [[ "$no" == "no" ]]
			then
				echo Exiting....
				break;
			fi
		done
	else
		echo "Please give the proper input"
	
	fi
        	echo "Do you want to continue with other instance ?"
                read yes
		if [[ "$yes" == "no" ]]
		then
                        echo Exiting....
                        break;
		fi
done
