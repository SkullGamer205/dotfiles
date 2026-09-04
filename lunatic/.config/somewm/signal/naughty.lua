local ruled   = require('ruled')

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            implicit_timeout = 5,
            position         = 'bottom_right',
        }
    }
end)

require('naughty').connect_signal('request::display', function(n)
    require('ui.notification')(n)
end)
