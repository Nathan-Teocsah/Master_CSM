void pgcd(int*i_a,int*i_b)
{
	int M;
	while (*i_a!= *i_b)
	{
	  if (*i_a<*i_b)
		 {
		   M=*i_b, *i_b=*i_a, *i_a=M-*i_b;
		 }
	  else
		 {
		   *i_a = *i_a-*i_b;
		 }
	}
}
