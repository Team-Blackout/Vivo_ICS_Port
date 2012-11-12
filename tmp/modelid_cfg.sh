#!/sbin/sh
#

# Remove KINETO on incorrect models.
#
# Valid:
# VISION   TMUS MODELID PC1010000
# MAHIMAHI TMUS MODELID PB9910000
# GLACIER  TMUS MODELID PD1510000
# ESPRESSO TMUS MODELID PB6510000
# SAGA     TMUS MODELID PG8810000 | PG8811000 | PG8812000 | PG8813000
#

kineto=/system/app/MS-HTCEMR-KNT20-02-A0-GB-02.apk
rm_kineto=y

cat /proc/cmdline|egrep -q '(PC1010000)|(PB9910000)|(PD1510000)|(PB6510000)'
if [ $? = 0 ];
    then
       rm_kineto=n
fi

if [ "$rm_kineto" = "y" ];
    then
       if [ -f $kineto ];
          then
             rm -f /system/app/MS-HTCEMR-KNT20-02-A0-GB-02.apk
             rm -f /system/lib/libkineto.so
             rm -f /system/lib/libganril.so
             rm -f /system/lib/librilswitch.so
             sed 's/librilswitch.so/libhtc_ril.so/' /system/build.prop > /tmp/build.tmp
             sed '/rilswitch/d' /tmp/build.tmp > /system/build.prop
             chmod 644 /system/build.prop
             rm /tmp/build*
       fi
fi

# Check for Glacier, apply board specific settings for build.prop
#
	cat /proc/cmdline | egrep -q '(PD1510000)'
		if [ $? = 0 ];
			then
				sed -i 's/ro.product.display_resolution.*=.*/ro.product.display_resolution=3.8 inch WVGA resolution/g' /system/build.prop	
				sed -i 's/ro.product.main_camera.*=.*/ro.product.main_camera=5M/g' /system/build.prop	
				sed -i 's/ro.product.front_camera.*=.*/ro.product.front_camera=VGA/g' /system/build.prop
				sed -i 's/ro.aa.modelid.*=.*/ro.aa.modelid=PD1510000/g' /system/build.prop
				sed -i 's/ro.product.model.*=.*/ro.product.model=HTC MyTouch\ 4G/g' /system/build.prop
				sed -i 's/ro.product.device.*=.*/ro.product.device=glacier/g' /system/build.prop
				sed -i 's/ro.product.board.*=.*/ro.product.board=glacier/g' /system/build.prop					
				sed -i 's/ro.build.host.*=.*/ro.build.host=ABM009/g' /system/build.prop
				sed -i 's/ro.build.user.*=.*/ro.build.user=user/g' /system/build.prop
				sed -i 's/ro.build.product.*=.*/# ro.build.product=/g' /system/build.prop
				sed -i 's/ro.ril.hsupa.category.*=.*/ro.ril.hsupa.category=7/g' /system/build.prop
				sed -i 's/ro.ril.hsdpa.category.*=.*/ro.ril.hsdpa.category=10/g' /system/build.prop
		fi

# Check for Vision, apply board specific settings for build.prop
#
	cat /proc/cmdline | egrep -q '(PC1010000)'
		if [ $? = 0 ];
			then
				sed -i 's/ro.product.display_resolution.*=.*/ro.product.display_resolution=3.7\ inch\ WVGA\ resolution/g' /system/build.prop
				sed -i 's/ro.product.main_camera.*=.*/ro.product.main_camera=5M/g' /system/build.prop
				sed -i 's/ro.product.processor.*=.*/ro.product.processor=800MHZ/g' /system/build.prop
				sed -i 's/ro.product.ram.*=.*/ro.product.ram=512MB/g' /system/build.prop
				sed -i 's/ro.aa.modelid.*=.*/ro.aa.modelid=PC1010000/g' /system/build.prop
				sed -i 's/ro.product.model.*=.*/ro.product.model=HTC\ Desire\ Z/g' /system/build.prop
				sed -i 's/ro.product.device.*=.*/ro.product.device=vision/g' /system/build.prop
				sed -i 's/ro.product.board.*=.*/ro.product.board=vision/g' /system/build.prop
				sed -i 's/ro.build.host.*=.*/ro.build.host=ABM009/g' /system/build.prop
				sed -i 's/ro.build.user.*=.*/ro.build.user=user/g' /system/build.prop
				sed -i 's/ro.build.product.*=.*/# ro.build.product=/g' /system/build.prop
				sed -i 's/ro.ril.hsupa.category.*=.*/ro.ril.hsupa.category=7/g' /system/build.prop
				sed -i 's/ro.ril.hsdpa.category.*=.*/ro.ril.hsdpa.category=10/g' /system/build.prop
		fi

# Check for Saga, apply board specific settings for build.prop
#
	cat /proc/cmdline | egrep -q '(PG8810000)|(PG8811000)|(PG8812000)|(PG8813000)'
		if [ $? = 0 ];
			then
				sed -i 's/ro.product.display_resolution.*=.*/ro.product.display_resolution=3.7 inch WVGA resolution/g' /system/build.prop	
				sed -i 's/ro.product.main_camera.*=.*/ro.product.main_camera=5M/g' /system/build.prop	
				sed -i 's/ro.product.front_camera.*=.*/ro.product.front_camera=VGA/g' /system/build.prop
				sed -i 's/ro.aa.modelid.*=.*/ro.aa.modelid=PG8810000,PG8811000,PG8812000,PG8813000/g' /system/build.prop
				sed -i 's/ro.product.model.*=.*/ro.product.model=HTC Desire\ S/g' /system/build.prop
				sed -i 's/ro.product.device.*=.*/ro.product.device=saga/g' /system/build.prop
				sed -i 's/ro.product.board.*=.*/ro.product.board=saga/g' /system/build.prop					
				sed -i 's/ro.build.host.*=.*/ro.build.host=ABM032/g' /system/build.prop
				sed -i 's/ro.build.user.*=.*/ro.build.user=user/g' /system/build.prop
				sed -i 's/ro.build.product.*=.*/# ro.build.product=/g' /system/build.prop
				sed -i 's/ro.ril.hsupa.category.*=.*/ro.ril.hsupa.category=6/g' /system/build.prop
				sed -i 's/ro.ril.hsdpa.category.*=.*/ro.ril.hsdpa.category=8/g' /system/build.prop
		fi
		
# Check for spade; if NAM model update DSP and GPS config
#
# NAM Models:
# Inspire AT&T  MODELID PD9812000
# DHD TELUS MODELID PD9814000
#

cat /proc/cmdline | grep -q spade
if [ $? = 0 ];
   then
cat /proc/cmdline | egrep -q '(PD9812000)'
		if [ $? = 0 ];
			then		
				sed -i 's/ro.aa.modelid.*=.*/ro.aa.modelid=PD9812000/g' /system/build.prop
				sed -i 's/ro.product.model.*=.*/ro.product.model=Inspire\ 4G/g' /system/build.prop
				sed -i 's/ro.build.host.*=.*/ro.build.host=AA133/g' /system/build.prop
				sed -i 's/ro.build.user.*=.*/ro.build.user=user/g' /system/build.prop
				sed -i 's/ro.build.product.*=.*/# ro.build.product=/g' /system/build.prop
				sed -i 's/ro.ril.hsupa.category.*=.*/ro.ril.hsupa.category=7/g' /system/build.prop
				sed -i 's/ro.ril.hsdpa.category.*=.*/ro.ril.hsdpa.category=10/g' /system/build.prop
			else
	cat /proc/cmdline | egrep -q '(PD9814000)'
		if [ $? = 0 ];
			then		
				sed -i 's/ro.aa.modelid.*=.*/ro.aa.modelid=PD9814000/g' /system/build.prop
				sed -i 's/ro.product.model.*=.*/ro.product.model=Telus\ HD/g' /system/build.prop
				sed -i 's/ro.build.host.*=.*/ro.build.host=AA133/g' /system/build.prop
				sed -i 's/ro.build.user.*=.*/ro.build.user=user/g' /system/build.prop
				sed -i 's/ro.build.product.*=.*/# ro.build.product=/g' /system/build.prop
				sed -i 's/ro.ril.hsupa.category.*=.*/ro.ril.hsupa.category=7/g' /system/build.prop
				sed -i 's/ro.ril.hsdpa.category.*=.*/ro.ril.hsdpa.category=10/g' /system/build.prop
#			else
		fi
	fi
fi



