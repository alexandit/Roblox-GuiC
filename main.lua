local Compiler = require("guic");
local Script = [[
  {start: guic} : {
    lua : {
      print("An easier way to make guis through script for ROBLOX");
    }
    {screenGui} : {
      {"MyScreenGui"} : {
        ${enabled} : {true};
        ${name} : {"MyScreenGui"};
        ${parent} : {game.Players.LocalPlayer.PlayerGui};
      };
    }
   {frame} : {
      {"MyFrame1"} : {
        ${parent} : {MyScreenGui};
        ${name} : {"MyFrame1"};
      };
    }
   {textLabel} : {
      {"SayHello"} : {
        ${text} : {"Hello, Person!"};
      };
    }
  }
]];

return print(Compiler:Compile(Script));
