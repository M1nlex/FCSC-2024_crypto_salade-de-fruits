from hashlib import sha256
from datetime import datetime

N=94
max_num=100

def reverse_nums(u,v):
	a = (36*N+v)/(6*u)
	b = (36*N-v)/(6*u)
	return a,b

def put_in_file(x,y,z,sign):
	with open("res.txt", 'a') as f:
		f.write("=================================\n")
		f.write("found for N="+str(N)+", at "+str(datetime.now())+"\n")
		f.write("X="+str(x)+"\n")
		f.write("Y="+str(y)+"\n")
		f.write("Z="+str(z)+"\n")
		f.write("SHA="+str(sign)+"\n")


R.<u,v> = QQ[]
E= EllipticCurve(u^3-432*N**2-v^2)

print(E)
print("With rank "+str(E.rank()))

P=E.gens()[0]

i=1
while(True):
	P_i = i*P
	if P_i[0] > 0 and abs(P_i[1]) < 36*N:
		a,b = reverse_nums(P_i[0], P_i[1])
		if (a.denom()==b.denom()):
			x=a.numer()
			y=b.numer()
			z=a.denom()
			if x^3+y^3 == N*z^3:
				signature = sha256(str(z).encode()).hexdigest()
				print("signature=")
				print(f"FCSC{{{signature}}}")
				put_in_file(x,y,z,signature)
				print("success")
				break
			else:
				print("fail")
	if i == max_num:
		break
	i+=1
