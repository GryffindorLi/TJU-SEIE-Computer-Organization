void prints(volatile int ptr){ // ptr is passed through register a0
    asm("li a7, 1");
    asm("ecall");
}

int fac(int n)
{
	int res;
	if(n<1)
		return 0;
	else if(n==0||n==1)
		res=1;
	else
		res=n*fac(n-1);
	return res;
}

int main()
{
	int n=4;
	int result;
	result = fac(n);
	prints(result);
	return 0;
}
