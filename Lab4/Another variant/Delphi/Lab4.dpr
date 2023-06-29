program Lab4;
{
 Given a non-empty sequence of words consisting of lowercase
 Russian letters, with commas between adjacent words and
 a period after the last word. Output all voiced consonant
 letters that appear in at least one word, in alphabetical order.
}

uses
  System.SysUtils;

type
  TZvonkSogl = (�, �, �, �, �, �, �, �, �, �);
  TSetOfZvonkSogl = set of TZvonkSogl;
  // TZvonkSogl - enumerates voiced consonant letters
  // TSetOfZvonkSogl - defines a set of voiced consonant letters

const
  // Voiced consonant letters set
  ZvonkSogl = ['�', '�', '�', '�', '�', '�', '�', '�', '�', '�'];

function GetTypeOfZvonkSogl(const AChar: AnsiChar): TZvonkSogl;
begin
  // Maps a character to its corresponding voiced consonant letter
  case AChar of
    '�': Result := TZvonkSogl.�;
    '�': Result := TZvonkSogl.�;
    '�': Result := TZvonkSogl.�;
    '�': Result := TZvonkSogl.�;
    '�': Result := TZvonkSogl.�;
    '�': Result := TZvonkSogl.�;
    '�': Result := TZvonkSogl.�;
    '�': Result := TZvonkSogl.�;
    '�': Result := TZvonkSogl.�;
    '�': Result := TZvonkSogl.�;
  end;
end;

function GetCharFromZvonkSogl(const AZvonkSogl: TZvonkSogl): AnsiChar;
begin
  // Maps a voiced consonant letter to its corresponding character
  case AZvonkSogl of
    TZvonkSogl.�: Result := '�';
    TZvonkSogl.�: Result := '�';
    TZvonkSogl.�: Result := '�';
    TZvonkSogl.�: Result := '�';
    TZvonkSogl.�: Result := '�';
    TZvonkSogl.�: Result := '�';
    TZvonkSogl.�: Result := '�';
    TZvonkSogl.�: Result := '�';
    TZvonkSogl.�: Result := '�';
    TZvonkSogl.�: Result := '�';
  end;
end;

procedure InstallZvonkSogl(const ASequence: AnsiString; var ASetOfZvonkSogl: TSetOfZvonkSogl);
var
  CurrWord, RemWords: AnsiString;
  CommaIndex: Integer;
  I: Integer;
begin
  // Extracts voiced consonant letters from the given sequence and adds them to the set
  CommaIndex := Pos(',', ASequence);
  if CommaIndex = 0 then
  begin
    // If there are no commas, the current word is the entire sequence
    CurrWord := ASequence;
    RemWords := '';
  end
  else
  begin
    // Extracts the current word and the remaining words from the sequence
    CurrWord := Copy(ASequence, 1, CommaIndex - 1);
    RemWords := Copy(ASequence, CommaIndex + 1, Length(ASequence));
  end;

  for I := 1 to Length(CurrWord) do
    if CurrWord[I] in ZvonkSogl then
      Include(ASetOfZvonkSogl, GetTypeOfZvonkSogl(CurrWord[I]));

  if RemWords <> '' then
    // Recursively process the remaining words in the sequence
    InstallZvonkSogl(RemWords, ASetOfZvonkSogl);
end;

function GetCorrectStr: AnsiString;
var
  isCorrect: Boolean;
  I, StrHigh: Integer;
  function IsValidCharacter(const AChar: AnsiChar): Boolean;
  begin
    // Checks if a character is a valid lowercase Russian letter
    Result := (AChar >= '�') and (AChar <= '�');
  end;
begin
  // Reads a string from input and performs validation on the format and characters
  repeat
    isCorrect:= True;
    Readln(Result);
    Result := LowerCase(Result);

    if Result[High(Result)] <> '.' then
    begin
      Writeln('������������ ����');
      isCorrect:= False;
    end;

    I := 1;
    StrHigh := Length(Result) - 2;
    while (I <= StrHigh) and isCorrect do
    begin
      if ((Result[I] = ',') and not IsValidCharacter(Result[I + 1])) or
         (Result[I] <> ',') and not IsValidCharacter(Result[I]) then
      begin
        Writeln('������������ ����');
        isCorrect:= False;
      end;
      Inc(I);
    end;

  until isCorrect;
end;

var
  Sequence: AnsiString;
  SetOfZvonkSogl: TSetOfZvonkSogl;
begin
  // Main program logic
  Writeln('������� ������������������ ���� (������� ����� ��������� �������, ����� ����� ���������� �����):');
  Sequence:= GetCorrectStr;
  InstallZvonkSogl(Sequence, SetOfZvonkSogl);

  Writeln('������� ��������� ������� ��������� �����, ������� ������ ���� �� � ���� �����:');
  for var I := Low(TZvonkSogl) to High(TZvonkSogl) do
    if I in SetOfZvonkSogl then
      Write(GetCharFromZvonkSogl(I), ' ');
  Writeln;
  Readln;
end.

