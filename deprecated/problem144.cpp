/*
 * problem144.cpp
 *
 *  Created on: Oct 25, 2012
 *      Author: ruben
 */


#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <utility>
#include "mpreal.h"

using mpfr::mpreal;



inline mpreal power (mpreal a, mpreal p)
{
	if (p == 0)
		return 0;
	if (p == 1)
		return a;
	else
		return a * power (a, p - 1);
}


mpreal findSlope (std::pair<mpreal, mpreal> xy)
{
	return ((mpreal) -4) * (xy.first / xy.second);
}


mpreal perpendicular (mpreal slope)
{
	return (mpreal) -1 / slope;
}


mpreal calculateOffset (mpreal m, std::pair<mpreal, mpreal> xy)
{
	return (-m * xy.first + xy.second);
}

/*
mpreal abs (mpreal a)
{
	return (a < 0)? -a : a;
}
*/

bool prettyEqual (mpreal a, mpreal b)
{
	mpreal diff = abs (a - b);
	return (diff - 0.0000000000000001 < 0);
}


std::pair<mpreal, mpreal> findIntersection (mpreal m,
											mpreal b,
											std::pair<mpreal, mpreal> xy)
{
	mpreal D = 4 * power(b, 2) * power(m, 2) -
			   4 * (power(b, 2) - 100) * (power(m, 2) + 4);
    mpreal x1 = (-2 * b * m + (sqrt(D))) / (2 * (power(m, 2)) + 8);
    mpreal x2 = (-2 * b * m - (sqrt(D))) / (2 * (power(m, 2)) + 8);
    mpreal y1 = m * x1 + b;
    mpreal y2 = m * x2 + b;
    if (prettyEqual (x1, xy.first) and prettyEqual (y1, xy.second))
    	return std::pair<mpreal, mpreal> (x2, y2);
    else
    	return std::pair<mpreal, mpreal> (x1, y1);
}


mpreal calculateNextSlope (mpreal startslope, mpreal normslope)
{
	mpreal m1 = -(2 * startslope * normslope - (power(normslope, 2)) + 1) /
			     (2 * normslope - startslope * (power(normslope, 2)) - startslope);
	mpreal m2 = -1 / m1;
	if (m1 > normslope)
		return m1;
	else
		return m2;
}


long doProblem (mpreal startslope, mpreal startoffset, std::pair<mpreal, mpreal> xy)
{
	std::pair<mpreal, mpreal> resultingIntersection(findIntersection(startslope, startoffset, xy));
	double x, y;
	x = resultingIntersection.first.toDouble();
	y = resultingIntersection.second.toDouble();
	std::cout << x << y << std::endl;
	if (((x < 0.01) || (x > -.01)) && prettyEqual (y, 10))
		return 0;
	else {
		mpreal normslope = perpendicular (findSlope (resultingIntersection));
		mpreal newslope = calculateNextSlope (startslope, normslope);
		mpreal newoffset = calculateOffset (newslope, resultingIntersection);
		return 1 + doProblem (newslope, newoffset, resultingIntersection);
	}
}

/*
int main(void)
{
	// Required precision of computations in decimal digits
	// Play with it to check different precisions
	const int digits = 50;

	// Setup default precision for all subsequent computations
	// MPFR accepts precision in bits - so we do the conversion
	mpreal::set_default_prec(mpfr::digits2bits(digits));

	mpreal startslope = -19.7/1.4;
	mpreal startoffset = 10.1;
	std::pair<mpreal, mpreal> startcoords (0.0, 10.1);

	std::cout << doProblem (startslope, startoffset, startcoords) << std::endl;
}

*/
