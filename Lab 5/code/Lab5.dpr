program Lab5;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  nums: array[1..9] of Integer;
  biggerThan, quantityOf, i: Integer;

begin
  randomize;
  for i:= 1 to 9 do
    nums[i]:=random(200);

  for i:= 1 to 9 do
    write(nums[i], ' ');

  writeln;

  asm
    mov ecx, 0
  @cycle:
    mov eax, dword[nums+ecx]
    cmp eax, 100
    jng @skip

    add biggerThan, eax
    add quantityOf, 1

    @skip:
    add ecx, 4
    cmp ecx, 36
  jl @cycle
  end;

  writeln;
  write('The sum of elements bigger then 100: ', biggerThan);
  writeln;
  write('The amount of elements bigger then 100: ', quantityOf);

  readln;
end.
