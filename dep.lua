local a = {};

local function returnVal(s, f)
  return string.format(s, f);
end
function a:quoteGet(s, n)
  local v = {['"']=0,["'"]=0};
  if not v[s:sub(n, n)] then return false end;
  local k = "";
  local ni = n;

  repeat
    k = k .. s:sub(ni,ni);
    ni=ni+1;
  until s:sub(ni,ni) == '"' and s:sub(ni-1,ni-1) ~= "\\";
  k=k..'"'
  return k, ni
end;

a.promptK = 
{
  ["frame"]=true,
  ["textBox"]=true,
  ["imageButton"]=true,
  ["scrollingFrame"]=true,
  ["screenGui"]=true,
  ["imageLabel"]=true,
  ["textLabel"]=true,
}

a.promptP =
{
  ["bgcolor:BackgroundColor3"]=true,
  ["position:Position"]=true,
  ["size:Size"]=true,
  ["name:Name"]=true,
  ["bdcolor:BorderColor3"]=true,
  ["bgtrans:BackgroundTransparency"]=true,
  ["enabled:Enabled"]=true,
  ["visible:Visible"]=true;
  ["parent:Parent"]=true;
  ["bdsizep:BorderSizePixel"]=true;
  ["active:Active"]=true;
  ["canvasSize:CanvasSize"]=true;
  ["text:Text"]=true,
  ["textsize:TextSize"]=true,
  ["textcolor:TextColor"]=true,
}
a.promptReturn = 
{
  ["bgcolor"]="Color3.fromRGB(%s);",
  ["position"]= "UDim2.new(%s);",
  ["size"]="UDim2.new(%s);",
  ["canvasSize"]="UDim2.new(%s);",
  ["textcolor"]="Color3.fromRGB(%s);"
}

a.format = returnVal
