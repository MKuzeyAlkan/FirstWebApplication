using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace FirstWebApplication.App_Code
{
    public class LogHub : Hub
    {
        public static readonly System.Timers.Timer _Timer = new System.Timers.Timer();

        static LogHub()
        {
            _Timer.Interval = 5000;
            _Timer.Elapsed += TimerElapsed;
            _Timer.Start();
        }

        static void TimerElapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            var hub = GlobalHost.ConnectionManager.GetHubContext("LogHub");
            hub.Clients.All.logMessage(string.Format("{0} - Still running", DateTime.UtcNow));
        }

        public override Task OnDisconnected(bool stopCalled)
        {
            return base.OnDisconnected(stopCalled);
        }

        public override Task OnConnected()
        {
            var hub = GlobalHost.ConnectionManager.GetHubContext("LogHub");
            hub.Clients.All.WelcomeMessage(string.Format("{0} - Welcome To SignalR", DateTime.UtcNow));
            return base.OnConnected();
        }

        public override Task OnReconnected()
        {
            return base.OnReconnected();
        }

    }
}