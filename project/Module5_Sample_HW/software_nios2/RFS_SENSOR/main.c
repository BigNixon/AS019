/*
 * main.c
 *
 *  Created on: 2016/10/14
 *      Author: User
 */

#include <stdio.h>
#include "system.h"
#include "esp8266.h"
#include <string.h>
#include <unistd.h>
#include "terasic_includes.h"
#include "shared_mem_def.h"
#include <fcntl.h>
#include "math.h"
#include <stdlib.h>
//#include "SEG7.h"

#include "light_sensor.h"
#include "rh_temp.h"

bool get_gppm(float *gas);

void getMotion9(float *ax, float *ay, float *az, float *gx, float *gy, float *gz, float *mx, float *my, float *mz);
void MPU9250_Init(alt_u32 I2C_Controller_Base);
bool MPU9250_initialize();
unsigned sp_themperature_out;
const char *time_server_domain = "192.168.1.19";

const char *get_time_request =
        "GET / HTTP/1.1\r\nHost: 192.168.1.19 \r\nConnection: close\r\n\r\n";

bool get_gppm(float *gas)
{
    bool success = true;
    char str[100];
    char cmd_buffer[100];
    char buffer[1000];\
    char* pend;
    if (success) {
        sprintf(cmd_buffer, "AT+CIPSTART=\"TCP\",\"%s\",80",
                time_server_domain);
        success = esp8266_send_command(cmd_buffer);
    }
    if (success) {
        sprintf(cmd_buffer, "AT+CIPSEND=%d", strlen(get_time_request));
        success = esp8266_send_command(cmd_buffer);
    }
    if (success) {
        success = esp8266_send_data(get_time_request, strlen(get_time_request));
    }

    int length = 0;

    if (success) {
        while (1) {
            esp8266_gets(buffer, sizeof(buffer));
            if (strstr(buffer, "+IPD") != NULL) {
                length = strlen(buffer);
                while (1) {
                    esp8266_gets(buffer + length, sizeof(buffer) - length);
                    if (strcmp(buffer + length, "\r\n") == 0)
                        break;
                    length += strlen(buffer + length);

                }

                break;
            }
        }
        //printf("%d\n",length);
        esp8266_gets(buffer, 9);
        //printf("time: %s\n", buffer);
    }

    if (success) {
        strcpy(str, buffer);

        *gas=strtof(str,&pend);

    } else {
    	success=false;

    }
    return success;
}

static struct {
	int light[2][2];
	float lux[2];
	float fTemperature[2];
	float fHumidity[2];
	float a[3][2];
	float g[3][2];
	float m[3][2];
	float gas[2];
	float spTemperature[2];
} thresh;

bool convert_light_lux(int light0, int light1, float *lux){
	float condition = (float)light1/(float)light0;
	if 			(0 < condition    && condition <= 0.50) *lux = (0.0304 * light0) - (0.062 * light0 * powf(condition,1.4));
	else if (0.50 < condition && condition <= 0.61) *lux = (0.0224 * light0) - (0.031 * light1);
	else if (0.61 < condition && condition <= 0.80) *lux = (0.0128 * light0) - (0.0153 * light1);
	else if (0.80 < condition && condition <= 1.30) *lux = (0.00146 * light1) - (0.00112 * light1);
  else *lux = 0;
	return TRUE;
}


void  set_thresh( void ){

  unsigned offst;
  union {
  	unsigned u;
  	float f;
  } uf ;

  // Light threshold
  //offst=128;
  offst = LIGHT0_SENSOR_L_THRESH>>2;

	for (int i=0; i<2 ; i++) {
		thresh.light[0][i] = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
		//0X2000+128,0X2000+129
	}

  //offst=130
  offst = LIGHT1_SENSOR_L_THRESH>>2;
	for (int i=0; i<2 ; i++) {
		thresh.light[1][i] = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
		//0X2000+130,0X2000+131
	}

  //offst=132
  offst = LUX_SENSOR_L_THRESH >>2;
	for (int i=0; i<2 ; i++) {
		uf.u = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
		thresh.lux[i] = uf.f;
	    //0X2000+132,0X2000+133
	}

  // Temp. HM. threshold
  //offst=134
  offst = HUMIDI_SENSOR_L_THRESH>>2;
	for (int i=0; i<2 ; i++) {
		uf.u = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
		thresh.fHumidity[i] = uf.f;
		//2000+134,2000+135
	}

  //offst=136
  offst = TEMPER_SENSOR_L_THRESH>>2;
	for (int i=0; i<2 ; i++) {
		uf.u = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
		thresh.fTemperature[i] = uf.f;
		//0X2000+136,0X2000+137
	}

  // 9-axis threshold
  //offst=138
  offst = ACCEL_X_SENSOR_L_THRESH>>2;
  float *fp=&thresh.a[0][0];
	for (int i=0; i<6 ; i++) {
		uf.u = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
		*fp++ = uf.f;
		//0X2000+138,0X2000+139,0X2000+140,0X2000+141,0X2000+142,0X2000+143
	}
  //offst=144
  offst = GYROS_X_SENSOR_L_THRESH>>2;
  fp=&thresh.g[0][0];
	for (int i=0; i<6 ; i++) {
		uf.u = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
		*fp++ = uf.f;
		//0X2000+144,0X2000+145,0X2000+146,0X2000+147,0X2000+148,0X2000+149
	}

  //offst=150
  offst = MAGNE_X_SENSOR_L_THRESH>>2;
  fp=&thresh.m[0][0];
	for (int i=0; i<6 ; i++) {
		uf.u = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
		*fp++ = uf.f;
		//0X2000+150,0X2000+151,0X2000+152,0X2000+153,0X2000+154,0X2000+155
	}

  //offst=156
  offst= GAS_CN0395_SENSOR_L_THRESH>>2;
  for (int i=0; i<2 ; i++) {
  		uf.f = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
  		thresh.gas[i] = uf.f;
  		//2000+156,2000+157
  	}

  //offst=162
  offst= SETPOINT_TEMPERATURE_TRESH>>2;
  for (int i=0; i<2 ; i++) {
  		uf.f = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
  		thresh.spTemperature[i] = uf.f;
  		//2000+156,2000+157
  	}
  sp_themperature_out = IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++);
}


#define is_OutOfRange(a,THptr) ( ((a) < ((THptr)[0])) || ((a)>(((THptr)[1]))) )
#define SET_OUT_OF_RANGE_LED(v)  IOWR(NIOS_SYSTEM_LED_PIO_BASE, 0, (v) )

bool check_light_threshold(int light0, int light1,float lux){
	bool rv=false;
	if (
	     is_OutOfRange(lux, &thresh.lux[0]         ) ) {
		rv = true;
	}
	return rv;
}
bool check_temp_hm_threshold(float temp, float hm){
	bool rv=false;
	if ( is_OutOfRange(temp, &thresh.fTemperature[0] ) ||
	     is_OutOfRange(hm,   &thresh.fHumidity[0]    ) ) {
		rv = true;
	}
	return rv;
}

bool check_temp_ax9_threshold(float a[3], float g[3], float m[3]){
	bool rv=false;
	int err=0;
	for ( int i=0;i<3; i++){
		if ( is_OutOfRange(a[i], &thresh.a[i][0]))
			err++;
	}
	for ( int i=0;i<3; i++){
		if ( is_OutOfRange(g[i], &thresh.g[i][0]))
			err++;
	}
	for ( int i=0;i<3; i++){
		if ( is_OutOfRange(m[i], &thresh.m[i][0]))
			err++;
	}

	if (err) {
		rv=true;
	}
	return rv;
}

bool check_gas_cn0395_threshold(float gas){
	bool rv=false;
	if ( is_OutOfRange(gas, &thresh.gas[0]))  {
		rv = true;
	}
	return rv;
}


bool check_sp_temperature_threshold(float spTemperature){
	bool rv=false;
	if ( is_OutOfRange(spTemperature, &thresh.spTemperature[0]))  {
		rv = true;
	}
	return rv;
}

#define DEBUG

static bool g_clear_OOR_flag=true;

void Sensor_Report(bool print_flag){
  	bool bPass, bPass2;

  	////////////////////////////////
  	// report light sensor
  	alt_u16 light0 = 0, light1 = 0;
		float lux = 0;
  	bPass = Get_light(&light0, &light1);
	  if(bPass) {
			bPass2 = convert_light_lux(light0, light1, &lux);
		}
		else bPass2 = FALSE;

  	if (print_flag) {
			if(bPass2) {
	  		printf("light0 = %d, light1 = %d, lux = %.3f\r\n", light0, light1,lux);
			}
			else if (bPass) {
	  		printf("light0 = %d, light1 = %d,but getting lux value failed\r\n", light0, light1);
			}
	  	else{
	  		printf("get light0 and light1 values failed!\r\n");
	  	}
  	}

  	////////////////////////////////
  	// report HDC1000 temperature & humidity sensor
  	float fTemperature, fHumidity;
  	bPass = RH_Temp_Sensor_Read(&fTemperature, &fHumidity);
  	if (print_flag) {
	  	if (bPass){
			printf("Temperature: %.3f*C\r\n", fTemperature);
	    	printf("Humidity: %.3f%%\r\n",fHumidity);
	  	}else{
	  		printf("Failed to ready Temperature/Humidity sensor!\r\n");
	  	}
  	}
  	float fgas;
  	bPass = get_gppm(&fgas);
  	if (print_flag) {
  		  	if (bPass){
  				printf("Gas: %.2f\r\n", fgas);
  		    }else{
  		  		printf("Failed to ready CN0395 sensor!\r\n");
  		  	}
  	 }
  	////////////////////////////////
  	// report mpu9250 9-axis sensor
  	float a[3];
  	float g[3];
  	float m[3];
  	getMotion9(
  	  &a[0], &a[1], &a[2],
  	  &g[0], &g[1], &g[2],
  	  &m[0], &m[1], &m[2]
  	);


  	////////////////////////////////
    // Check out of range, and set LED
	static int out_of_range=0;
	if ( g_clear_OOR_flag ) out_of_range=0;
	if ( check_light_threshold(light0, light1,lux) )
		out_of_range |= 1<<0;
	if ( check_temp_hm_threshold(fTemperature, fHumidity) )
		out_of_range |= 1<<1;
	if ( check_temp_ax9_threshold( a, g, m) )
		out_of_range |= 1<<2;
	SET_OUT_OF_RANGE_LED(out_of_range);


  	////////////////////////////////
    // Print out sensor values
  	if (print_flag) {
	  	printf("9-axis info:\r\n");
	  	printf("ax = %.3f, ay = %.3f, az = %.3f\r\n", a[0], a[1], a[2]);
	  	printf("gx = %.3f, gy = %.3f, gz = %.3f\r\n", g[0], g[1], g[2]);
	  	printf("mx = %.3f, my = %.3f, mz = %.3f\r\n", m[0], m[1], m[2]);
  	}
  	if (print_flag) {
#ifdef DEBUG
  	   ////////////////////////////////
       // Print out threshold values
	    int *pi=&thresh.light[0][0];
	    printf(" TH:light "); for (int i=0; i<4; i++) { printf("%d ", *pi++);} printf("\n");
	    float *pf;
	    pf=&thresh.lux[0];
	    printf(" TH:Lux "); for (int i=0; i<2; i++) { printf("%.3f ", *pf++);} printf("\n");
	    pf=&thresh.fTemperature[0];
	    printf(" TH:Temp "); for (int i=0; i<2; i++) { printf("%.3f ", *pf++);} printf("\n");
	    pf=&thresh.fHumidity[0];
	    printf(" TH:HM "); for (int i=0; i<2; i++) { printf("%.3f ", *pf++);} printf("\n");
	    pf=&thresh.a[0][0];
	    printf(" TH:a* "); for (int i=0; i<6; i++) { printf("%.3f ", *pf++);} printf("\n");
	    pf=&thresh.g[0][0];
	    printf(" TH:g* "); for (int i=0; i<6; i++) { printf("%.3f ", *pf++);} printf("\n");
	    pf=&thresh.m[0][0];
	    printf(" TH:m* "); for (int i=0; i<6; i++) { printf("%.3f ", *pf++);} printf("\n");
	    pf=&thresh.gas[0];
	    printf(" TH:gas* "); for (int i=0; i<2; i++) { printf("%.2f ", *pf++);} printf("\n");
#endif
	  	printf("\r\n");
  	}

  	////////////////////////////////EDITAR
    // Set sensor values in shared memory
  	unsigned offst;

  	// Light0,1
  	//offst=64
  	offst = LIGHT0_SENSOR_VALUE>>2;
  	IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst, light0);
  	//offst=65
  	offst = LIGHT1_SENSOR_VALUE>>2;
  	IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst, light1);

  	unsigned *p;
  	//offst=66
		offst = LUX_SENSOR_VALUE>>2;
  	p =(unsigned *)&lux;    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst, *p);

  	// Temp. and Humidity
  	offst = HUMIDI_SENSOR_VALUE>>2;
  	p =(unsigned *)&fHumidity;    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst, *p);
  	offst = TEMPER_SENSOR_VALUE>>2;
  	p =(unsigned *)&fTemperature; IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst, *p);

  	// 9-Axes
  	offst = ACCEL_X_SENSOR_VALUE>>2;
  	p =(unsigned *)&a[0];    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++, *p);
  	p =(unsigned *)&a[1];    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++, *p);
  	p =(unsigned *)&a[2];    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++, *p);
  	offst = GYROS_X_SENSOR_VALUE>>2;
  	p =(unsigned *)&g[0];    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++, *p);
  	p =(unsigned *)&g[1];    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++, *p);
  	p =(unsigned *)&g[2];    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++, *p);
  	offst = MAGNE_X_SENSOR_VALUE>>2;
  	p =(unsigned *)&m[0];    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++, *p);
  	p =(unsigned *)&m[1];    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++, *p);
  	p =(unsigned *)&m[2];    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++, *p);
  	offst = GAS_CN0395_SENSOR_VALUE>>2;
  	p =(unsigned *)&fgas;    IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, offst++, *p);


}
#define READ_COMMUNICATION_REGISTER IORD(NIOS_SYSTEM_SHARED_MEMORY_BASE, 1)
#define SEND_ACK_COMMUNICATION_REGISTER IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, 1, 0)
#define SEND_STATUS_REGISTER(x) IOWR(NIOS_SYSTEM_SHARED_MEMORY_BASE, 0, (x))



int main()
{
    while (esp8266_init(true) == false) {
        usleep(3 * 1000 * 1000);//3 seconds
    }
    fcntl(STDIN_FILENO, F_SETFL, O_NONBLOCK);

  	bool bPass = FALSE;

  	////////////////////////////////////
  	// init light sensor i2c and power on
  	Light_Init(LIGHT_I2C_OPENCORES_BASE);
  	bPass = Light_PowerSwitch(TRUE);
  	if(bPass)
  		printf("light sensor power up successful!\r\n");
  	else
  		printf("light sensor power up failed!\r\n");

  	////////////////////////////////////
  	// init HDC1000: temperature and humidity sensor
  	RH_Temp_Init(RH_TEMP_I2C_OPENCORES_BASE);
  	bPass = RH_Temp_Sensor_Init();
  	if(bPass)
  		printf("Init HDC1000 successful!\r\n");
  	else
  		printf("Init HDC1000 failed!\r\n");



  	////////////////////////////////////
  	//init MPU9250 9-axis sensor
  	MPU9250_Init(MPU_I2C_OPENCORES_BASE);
  	MPU9250_initialize();
  	printf("\r\n");

    int loop_cnt=0;


  	while(1){ // report every second

  		SEND_STATUS_REGISTER(loop_cnt|0x80000000);
  		//Mode select
  		unsigned com_reg = READ_COMMUNICATION_REGISTER;
		if ( (com_reg&0xffff0000)== 0xaaaa0000 ) {
			SEND_ACK_COMMUNICATION_REGISTER; // Send ACK
			switch (com_reg&0xffff) {
			case 1:
				g_clear_OOR_flag = false; break;
			case 2:
				g_clear_OOR_flag = true; break;
			default :
				break;
			}
		}

  		set_thresh();  // Read threshold values from shared memory and set the thresh struct
  		IOWR_ALTERA_AVALON_PIO_DATA(0x41100,sp_themperature_out);
  		// print out values once every 16 loops
  		bool print_flag = ((loop_cnt) & 0xF) == 0;
  		Sensor_Report(print_flag);

  		usleep(1000*50);

  		usleep(2000000);
  		loop_cnt++;

  	}


    return 0;
}


