$mask = '~(^%s:\n(?:^[ ].*\n?)*$)~m';
$pattern = sprintf($mask, 'Node2');
$r = preg_match($pattern, $yaml, $matches);
$node = reset($matches);
$yaml = <<<EOD

Node1:
  Child:
    GrandChild: foo
Node2:
  AnotherChild:
    AnotherGrandChild: bar
Node3:
  LastChild:
    LastGrandChild: foo
EOD;

$mask = '~
(                     # start matching group
  ^                   # a node start always at the beginning of a line
  %s:                 # placeholder for sprintf for the nodname + :
  $                   # end of line for the nodename
  \n
  (?:                 # non-matching group to hold all subsequent, indented lines
    ^                 # beginning of sublines
    (?:[ ]{2})+       # indentation is required, always a muliple of two spaces, non matching group
    .*\n?             # match anything else on that subsequent line, optionally the newline character
  )*                  # 0 or more subsequent, indented lines
)$                    # this ends a line, to not take over the newline of the last subsequent line (see \n? above).

# the following are modifiers:
# m - pcre multiline modifier (in php same as in perl)
# x - to allow spaces and the comments all over here ;)
~mx
';
$pattern = sprintf($mask, 'Node2');
$r = preg_match($pattern, $yaml, $matches);
$node = reset($matches);

var_dump($node);
