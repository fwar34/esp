PROJECT = 'test'
VERSION = '2.0.0'

require 'sys'
require 'log'

LOG_LEVEL = log.LOGLEVEL_TRACE

sys.taskInit(function()
	while true do
		-- log.info('test',array)
		log.info('Hello world!')
		sys.wait(1000)
	end
end)

sys.taskInit(function()
	while true do

	end
end)

sys.taskInit(function()
	while true do

	end
end)

sys.init(0, 0)
sys.run()