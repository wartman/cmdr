package cmdr;

using Std;

class Fragment {
  var foreground:Null<String> = null;
  var background:Null<String> = null;
  final options:Array<{ set:Int, unset:Int }> = [];
  final value:String;

  public function new(value) {
    this.value = value;
  }

  public function setForeground(code:String) {
    foreground = code;
    return this;
  }

  public function setBackground(code:String) {
    background = code;
    return this;
  }

  public function addOption(option) {
    options.push(option);
    return this;
  }

  public function apply() {
    var setCodes:Array<String> = [];
    var unsetCodes:Array<String> = [];

    if (foreground != null) {
      setCodes.push(foreground);
      unsetCodes.push(39.string());
    }
    if (background != null) {
      setCodes.push(background);
      unsetCodes.push(49.string());
    }

    for (option in options) {
      setCodes.push(option.set.string());
      unsetCodes.push(option.unset.string());
    }

    if (setCodes.length == 0) return value;

    return '\033[${setCodes.join(';')}m$value\033[${unsetCodes.join(';')}m';
  }
}
