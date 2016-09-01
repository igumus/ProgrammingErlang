%% This is the application resource file (.app file) for the 'base'
%% application.

{application, sellaprime,
 [{description, "The Prime Number Shop"},
  {vsn, "1.0"},
  {modules, [sellaprime_app, sellaprime_sup,area_server,
	     prime_server, my_alarm_handler]},
  {registered, [area_server, prime_server, sellaprime_sup]},
  {applications, [kernel, stdlib]},
  {mod, {sellaprime_app, []}},
  {start_phases, []}]}.