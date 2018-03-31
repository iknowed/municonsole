from urllib2 import urlopen
import sys
import django
sys.path.append('./django/municonsole')
from xml.dom import minidom
import formatter
import psycopg2
import time
import math
import re
import os
from muni.models import Vehicle
from muni.models import Route
from muni.models import RouteStop
from muni.models import Run
from muni.models import Path
from muni.models import Point
from muni.models import Stop
from muni.models import Speed
from muni.models import Direction
from muni.models import DirectionStop
from muni.models import DirectionPath

for route in Route.objects.all():
  print route.tag
  for direction in Direction.objects.filter(route=route):
    print direction.tag
    for datype in range(0,3):
      print datype
      for hour in range(0,24):
        print hour
        #print "npaths: "+str(len(DirectionPath.objects.filter(direction=direction).values().distinct('path_id')))
        for dpath in DirectionPath.objects.filter(direction=direction).values().distinct('path_id'):
          #print dpath['path_id']
          p = Path.objects.filter(id=dpath['path_id'],route=route,directionpath__direction=direction)[0]
          s = Speed(route=route,direction=direction,path=p,hour=hour,datype=datype,speed=0,max=-666,min=666,navg=0)
          s.save()

