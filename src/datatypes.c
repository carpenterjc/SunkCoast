#include "main.h"

int min(int a, int b)
{
  if(a < b)
  {
    return a;
  } else
  {
    return b;
  }
}
int max(int a, int b)
{
  if(a > b)
  {
    return a;
  } else
  {
    return b;
  }
}

int minmax(int lower, int upper, int n)
{
  if(lower > upper)
    LOG("lower > than upper!");
  n = max(lower, n);
  n = min(upper, n);
  return n;
}

Point pointAddPoint(Point a, Point b)
{
  Point out = NULL_POINT;
  out.x = a.x + b.x;
  out.y = a.y + b.y;
  return out;
}

FPoint fpointAddFPoint(FPoint a, FPoint b)
{
  FPoint out = NULL_FPOINT;
  out.x = a.x + b.x;
  out.y = a.y + b.y;
  return out;
}

Rectangle rectangleAddPoint(Rectangle a, Point b)
{
  Rectangle out = NULL_RECTANGLE;
  out.a = pointAddPoint(a.a, b);
  out.b = pointAddPoint(a.b, b);
  return out;
}

FRectangle frectangleAddFPoint(FRectangle a, FPoint b)
{
  FRectangle out = NULL_FRECTANGLE;
  out.a = fpointAddFPoint(a.a, b);
  out.b = fpointAddFPoint(a.b, b);
  return out;
}

Point pointInverse(Point a)
{
  Point out = NULL_POINT;
  out.x = -a.x;
  out.y = -a.y;
  return out;
}

FPoint fpointInverse(FPoint a)
{
  FPoint out = NULL_FPOINT;
  out.x = -a.x;
  out.y = -a.y;
  return out;
}

Point pointMultiply(Point a, int n)
{
  Point out = NULL_POINT;
  out.x = a.x * n;
  out.y = a.y * n;
  return out;
}

FPoint fpointMultiply(FPoint a, float f)
{
  FPoint out = NULL_FPOINT;
  out.x = a.x * f;
  out.y = a.y * f;
  return out;
}

Rectangle rectangleMultiply(Rectangle a, int n)
{
  Rectangle out = NULL_RECTANGLE;
  out.a = pointMultiply(a.a, n);
  out.b = pointMultiply(a.b, n);
  return out;
}

FRectangle frectangleMultiply(FRectangle a, float n)
{
  FRectangle out = NULL_FRECTANGLE;
  out.a = fpointMultiply(a.a, n);
  out.b = fpointMultiply(a.b, n);
  return out;
}

FPoint pointToFPoint(Point in)
{
  FPoint out = NULL_FPOINT;
  out.x = in.x;
  out.y = in.y;
  return out;
}

Point fpointToPoint(FPoint in)
{
  Point out = NULL_POINT;
  out.x = in.x;
  out.y = in.y;
  return out;
}

FRectangle rectangleToFRectangle(Rectangle in)
{
  FRectangle out = NULL_FRECTANGLE;
  out.a = pointToFPoint(in.a);
  out.b = pointToFPoint(in.b);
  return out;
}

Rectangle frectangleToRectangle(FRectangle in)
{
  Rectangle out = NULL_RECTANGLE;
  out.a = fpointToPoint(in.a);
  out.b = fpointToPoint(in.b);
  return out;
}

bool rectangleIntersect(Rectangle a, Rectangle b)
{
  if(a.a.x >= b.b.x) return FALSE;
  if(b.a.x >= a.b.x) return FALSE;
  if(a.a.y >= b.b.y) return FALSE;
  if(b.a.y >= a.b.y) return FALSE;
  return TRUE;
}

bool frectangleIntersect(FRectangle a, FRectangle b)
{
  if(a.a.x >= b.b.x) return FALSE;
  if(b.a.x >= a.b.x) return FALSE;
  if(a.a.y >= b.b.y) return FALSE;
  if(b.a.y >= a.b.y) return FALSE;
  return TRUE;
}

bool pointInRectangle(Point p, Rectangle r)
{
  if(p.x < r.a.x) return FALSE;
  if(p.x >= r.b.x) return FALSE;
  if(p.y < r.a.y) return FALSE;
  if(p.y >= r.b.y) return FALSE;
  return TRUE;
}

bool fpointInFRectangle(FPoint p, FRectangle r)
{
  if(p.x < r.a.x) return FALSE;
  if(p.x >= r.b.x) return FALSE;
  if(p.y < r.a.y) return FALSE;
  if(p.y >= r.b.y) return FALSE;
  return TRUE;
}
