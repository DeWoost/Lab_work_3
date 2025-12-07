program Lab3;

uses crt;

const
  root = -2.54573;

var
  key: char;
  UpLim, LowLim, result, NL: real;
  step, i, mN: integer;

function PervCurve(x: real): real;//первообразная
begin
  pervcurve := ((x*x*x*x)/4) - ((x*x*x)/3) - (2*x*x) + (18*x);
end;

function Curve(x: real): real;//кривая
begin
  curve := (x*x*x) - (x*x) - (2*x) + 18;
end;

function Simpson(var a, b: real; step: integer): real;//подсчет интеграла 
var
  h, sum, xi: real;
  i: integer;
begin
  if step mod 2 = 1 then
    step := step + 1;
  
  h := (b - a) / step;//ширина каждого прямоугольника
  sum := 0.0;//сумма интеграла 
  for i := 0 to step - 1 do
  begin
    xi := a + i * h;//текущая точка Х
    if i mod 2 = 0 then
      sum := sum + 2 * Curve(xi)
    else
      sum := sum + 4 * Curve(xi);
  end;
  Simpson := (h / 3) * sum;
  
end;

procedure checkData(LowLim, UpLim: real; step: integer);//проверка данных
begin
  clrscr;
  if (UpLim > LowLim) and (step > 0) then
    begin
    if LowLim < root then
      LowLim := root; 
    if UpLim < root then
      UpLim := root;
      writeln('Рассчет интеграла 2 * x ^ 3 + (1) * x ^ 2 + (3) * x + (5) ');
      result := Simpson(LowLim, UpLim, step);
      NL := abs(PervCurve(LowLim) - PervCurve(UpLim));
      writeln('Метод Симпсона: ', result:0:4);
      writeln('Метод Ньютона-Лейбница: ', NL:0:4);
      writeln('');
      writeln('Нажмите Enter для продолжения...');
      readln();
      clrscr;
    end
  else
  begin//сообщение об ошибке данных
    writeln('Неверный формат данных!');
    writeln('');
    writeln('Нажмите Enter для продолжения...');
    readln();
    clrscr;
  end;
end;

procedure error(var a, b: real; result: real);
var
  absoluteError, relativelError: real;
begin
  clrscr;
  if (UpLim > LowLim) and (step > 0) then
    begin
    if LowLim < root then
      LowLim := root;
    if UpLim < root then
      UpLim := root;
      result := Simpson(LowLim, UpLim, step);
      NL := abs(PervCurve(b) - PervCurve(a));
      absoluteError := abs(NL - result);//абсолютная погрешность 
      relativelError := abs(absoluteError / NL) * 100;//относительная погрешность
      writeln('Абсолютная погрешность: ', absoluteError:0:4);
      writeln('Относительная погрешность: ', relativelError:0:2, '%');
      writeln('');
      writeln('Нажмите Enter для продолжения...');
      readln();
      clrscr;  
      end
    else
    begin//сообщение об ошибке данных
      writeln('Неверный формат данных!');
      writeln('');
      writeln('Нажмите Enter для продолжения...');
      readln();
      clrscr;
    end;
end;

//основная программа
begin
  window(0, 0, 45, 45);
  clrscr;
  UpLim := 10;
  LowLim := 1;
  step := 1;
  mN := 1;
  while true do 
  begin
    clrscr; // очищаем экран перед отображением меню
   for i := 1 to 6 do
    begin
      case i of
        1: begin
             if mN = i then
               TextColor(LightGreen) // Подсветка выбранного пункта
             else
               TextColor(White);
             
             writeln('[1] - Ввод нижнего предела         || Текущее значние: ', LowLim);
           end;
        2: begin
             if mN = i then
               TextColor(LightGreen)
             else
               TextColor(White);
             
             writeln('[2] - Ввод верхнего предела        || Текущее значние: ', UpLim);
           end;
        3: begin
             if mN = i then
               TextColor(LightGreen)
             else
               TextColor(White);
             
             writeln('[3] - Ввод шага интегрирования     || Текущее значние: ', step);
           end;
        4: begin
             if mN = i then
               TextColor(LightGreen)
             else
               TextColor(White);
             
             writeln('[4] - Расчет интеграла');
           end;
        5: begin
             if mN = i then
               TextColor(LightGreen)
             else
               TextColor(White);
             writeln('[5] - Расчет погрешности');
           end;
        6: begin
             if mN = i then
               TextColor(LightGreen)
             else
               TextColor(White);
             
             writeln('[0] - Выход');
           end;
        else TextColor(White);
          
      end;
    end;

    writeln('');
    TextColor(LightBlue);
    writeln('Рассчет интеграла 1 * x ^ 3 + (-1) * x ^ 2 + (-2) * x + (18)');
    TextColor(LightBlue);
    writeln('Корень уравнения = -2.54573...');
    TextColor(LightGreen);
    writeln('Сейчас выбрано: ', mN);
    TextColor(White);
    

    // Чтение нажатой клавиши
    key := ReadKey;
    case key of 
      #38: // стрелка вверх
        begin
          mN := mN - 1;
          if mN < 1 then
            mN := 6; // зациклить выбор
        end;
      #40: // стрелка вниз
        begin
          mN := mN + 1;
          if mN > 6 then
            mN := 1; // зациклить выбор
        end;
      #13: // Enter
        begin
          case mN of
            1:
              begin
                clrscr;
                writeln('Ввод нижнего предела:');
                Readln(LowLim);
                clrscr;
              end;
            2: 
              begin
                clrscr;
                writeln('Ввод верхнего предела:');
                Readln(UpLim);
                clrscr;
              end;
            3:
              begin
                clrscr;
                writeln('Ввод шага интегрирования');
                Readln(step);
                clrscr;
              end;
            4: checkData(LowLim, UpLim, step); // проверка данных
            5: error(LowLim, UpLim, step); // расчет погрешности
            6: exit; // выход
          end;
        end;
    end;    
  end;
end.
