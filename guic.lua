local Compiler = {};
local TOOLS = require("dep");

function Compiler:Compile(p)
  local pkg;
  pkg = function(a,b,c,d,e)
    d = d or "outofrange";
    b = b or 1
    c = c or #a

    local new = '';
    local int = 1;
    repeat
      if d == "outofrange" then
        if string.find(a:sub(int), "^{[%s\t]*start[%s\t]*:[%s\t]*guic[%s\t]*}[%s\t\n]*:[%s\n\t]*%b{}[;]?") then
          local _, f, g = string.find(a:sub(int), "^{[%s\t]*start[%s\t]*:[%s\t]*guic[%s\t]*}[%s\t\n]*:[%s\n\t]*(%b{})[;]?");
          local finalproduct = pkg(g,1,#g,"keyword");
          new = finalproduct;
          return new;
        end
      elseif d == "keyword" then
        if string.find(a:sub(int), "^[%s\n\t]*lua[%s\n\t]*:[%s\n\t]*%b{}[;]?") then
          local _, f, val = string.find(a:sub(int), "^[%s\n\t]*lua[%s\n\t]*:[%s\n\t]*(%b{})[;]?[%s\n\t]*");
          val = val:sub(2,-2);
          new = new .. val .. "\n";
          int = int + f;
        end
        for i, v in pairs(TOOLS.promptK) do
          if string.find(a:sub(int), "^[%s\n\t]*{[%s\t]*" .. i .. "[%s\t]*}[%s\n\t]*:[%s\n\t]*%b{}[;]?") then
            local _, f, g = string.find(a:sub(int), "^[%s\n\t]*{[%s\t]*" .. i .. "[%s\t]*}[%s\n\t]*:[%s\n\t]*(%b{})[;]?");
            local product = pkg(g,1,#g,"setvar", {provName = i});
            new = new .. product
            int = int + f;
            -----
            break
          end
        end
      elseif d == "setvar" then
        if string.find(a:sub(int), "^[%s\n\t]*%b{}[%s\n\t]*:[%s\n\t]*%b{}[;]?") then
          local _, f, v, b = string.find(a:sub(int), "^[%s\n\t]*(%b{})[%s\n\t]*:[%s\n\t]*(%b{})[;]?");
          v=v:sub(3,-3);
          local tag = "local " .. v .. " = " .. ("Instance.new(\"%s\");"):format(string.upper(e.provName):sub(1,1) .. e.provName:sub(2)) .. "\n";
          new = new .. tag
          new = new .. pkg(b:sub(2,-2), 1, #b:sub(2,-2), "setproperty", {provName = e.provName, varName = v})
          int = int + f
        end
      elseif d == "setproperty" then
        if string.find(a:sub(int), "^[%s\n\t]*$%b{}[%s\n\t]*:[%s\n\t]*%b{}[;]?") then
          for i, j in pairs(TOOLS.promptP) do
            local _, f, match, value = string.find(a:sub(int), "^[%s\n\t]*$(%b{})[%s\n\t]*:[%s\n\t]*(%b{})[;]?");
            match=match:sub(2,-2)
            local real
            if match == i:match("(.+):") then
              local real = i:match(".-:(.+)");
              local tag = e.varName .. "." .. real .. " = "
              if TOOLS.promptReturn[match] then
                tag = tag .. TOOLS.format(TOOLS.promptReturn[match], value:sub(2,-2));
              else
                tag = tag .. value:sub(2,-2) .. ";";
              end
              tag = tag .. "\n";
              new = new .. tag;
              int = int + f;
              break
            end
          end
        end
      end
      int = int + 1;
    until int > #a
    return new
  end

  return pkg(p,1,#p);
end

return Compiler
