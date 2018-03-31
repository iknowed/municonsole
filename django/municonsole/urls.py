from django.conf.urls.defaults import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    #url(r'^$', 'municonsole.views.home', name='home'),
    #url(r'^municonsole/', include('municonsole.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^vehicle/$', 'vehicle.views.index'),
    url(r'^vehicle/run/$', 'vehicle.views.run'),
    url(r'^vehicle/route/(?P<tag>\w+)/$', 'vehicle.views.route'),
    url(r'^vehicle/(?P<vehicle_id>\d+)/$', 'vehicle.views.detail'),
    url(r'^vehicle/direction/(?P<tag>\w+)/$', 'vehicle.views.direction'),
    url(r'^run/$', 'run.views.index'),
    url(r'^run/map/(?P<run_id>\d+)/$', 'run.views.map'),
    url(r'^run/kml/(?P<run_id>\d+)/$', 'run.views.kml'),
    url(r'^admin/', include(admin.site.urls)),
)
