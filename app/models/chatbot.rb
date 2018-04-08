require 'programr'

brains = Dir.glob("lib/chatbot/*")

CHATBOT= ProgramR::Facade.new
CHATBOT.learn(brains)