class FourSimplex < ActiveRecord::Base


  def self.symbolToTable(what)
    if what == ">="
      return -1.0
    end
      return 1.0
  end

  def self.uzupelnij(params)
    sympleks_tab = [[],[],[],[],[],[],[], [], [], []]
    #licznik
    numerator = []
    #mianownik
    denominator = []
    
    numerator[0] = ''
    numerator[1] = ''
    numerator[2] = 'licznik'
    numerator[3] = params[:zx3].to_f
    numerator[4] = params[:zx1].to_f
    numerator[5] = params[:zx2].to_f
    numerator[6] = 0.0
    numerator[7] = 0.0
    numerator[8] = 0.0
    numerator[9] = 0.0
    #numerator[10] = 0.0

    denominator[0] = ''
    denominator[1] = ''
    denominator[2] = 'mianownik'
    denominator[3] = params[:yx3].to_f
    denominator[4] = params[:yx1].to_f
    denominator[5] = params[:yx2].to_f
    denominator[6] = 0.0
    denominator[7] = 0.0
    denominator[8] = 0.0
    denominator[9] = 0.0
    #denominator[10] = 0.0

    sympleks_tab[0][0] = ''
    sympleks_tab[0][1] = ''
    sympleks_tab[0][2] = 'licznik'
    sympleks_tab[0][3] = 0.0
    sympleks_tab[0][4] = 0.0
    sympleks_tab[0][5] = 0.0
    sympleks_tab[0][6] = 0.0
    sympleks_tab[0][7] = 0.0
    sympleks_tab[0][8] = 0.0
    sympleks_tab[0][9] = 0.0
    #sympleks_tab[0][10] = 0.0#-1.0  # U NAS TRZEBA ZAMIENIC 

    sympleks_tab[1][0] = ''
    sympleks_tab[1][1] = ''
    sympleks_tab[1][2] = 'mianownik'
    sympleks_tab[1][3] = 1.0
    sympleks_tab[1][4] = 0.0
    sympleks_tab[1][5] = 0.0
    sympleks_tab[1][6] = 0.0
    sympleks_tab[1][7] = 0.0
    sympleks_tab[1][8] = 0.0
    sympleks_tab[1][9] = 0.0
    #sympleks_tab[1][10] = 0.0

    sympleks_tab[2][0]='cB'
    sympleks_tab[2][1]='dB'
    sympleks_tab[2][2]='baza'
    sympleks_tab[2][3]='xB'
    sympleks_tab[2][4]='p1'
    sympleks_tab[2][5]='p2'
    sympleks_tab[2][6]='p3'
    sympleks_tab[2][7]='p4'
    sympleks_tab[2][8]='p5'
    sympleks_tab[2][9]='p6'
    #sympleks_tab[2][10]='p7'

    sympleks_tab[3][0]=0.0
    sympleks_tab[3][1]=0.0
    sympleks_tab[3][2]='p3'
    sympleks_tab[3][3]=params[:ax3].to_f
    sympleks_tab[3][4]=params[:ax1].to_f
    sympleks_tab[3][5]=params[:ax2].to_f
    sympleks_tab[3][6]=symbolToTable(params[:a_symbol])
    sympleks_tab[3][7]=0.0
    sympleks_tab[3][8]=0.0
    sympleks_tab[3][9]=0.0
    #sympleks_tab[3][10] = 0.0

    sympleks_tab[4][0]= -1.0
    sympleks_tab[4][1]=0.0
    sympleks_tab[4][2]='p7'
    sympleks_tab[4][3]=params[:bx3].to_f
    sympleks_tab[4][4]=params[:bx1].to_f
    sympleks_tab[4][5]=params[:bx2].to_f
    sympleks_tab[4][6]=0.0
    sympleks_tab[4][7]=symbolToTable(params[:b_symbol])
    sympleks_tab[4][8]=0.0
    sympleks_tab[4][9]=0.0
    #sympleks_tab[4][10] = 0.0

    sympleks_tab[5][0]=-1.0
    sympleks_tab[5][1]=0.0
    sympleks_tab[5][2]='p8'
    sympleks_tab[5][3]=params[:cx3].to_f
    sympleks_tab[5][4]=params[:cx1].to_f
    sympleks_tab[5][5]=params[:cx2].to_f
    sympleks_tab[5][6]=0.0
    sympleks_tab[5][7]=0.0
    sympleks_tab[5][8]=symbolToTable(params[:c_symbol])
    sympleks_tab[5][9]=0.0
    #sympleks_tab[5][10] = 0.0

    sympleks_tab[6][0]=-1.0
    sympleks_tab[6][1]=0.0
    sympleks_tab[6][2]='p9'
    sympleks_tab[6][3]=params[:dx3].to_f
    sympleks_tab[6][4]=params[:dx1].to_f
    sympleks_tab[6][5]=params[:dx2].to_f
    sympleks_tab[6][6]=0.0
    sympleks_tab[6][7]=0.0
    sympleks_tab[6][8]=0.0
    sympleks_tab[6][9]=symbolToTable(params[:d_symbol])
    #sympleks_tab[6][10] = 0.0

    sympleks_tab[7][0]=''
    sympleks_tab[7][1]='delta'
    sympleks_tab[7][2]='L'

    sympleks_tab[8][0]=''
    sympleks_tab[8][1]='delta'
    sympleks_tab[8][2]='M'

    sympleks_tab[9][0]=''
    sympleks_tab[9][1]='delta'
    sympleks_tab[9][2]='B'
    calculate_deltas(sympleks_tab)

    return {sympleks_tab: sympleks_tab, numerator: numerator, denominator: denominator}
  end

  def self.calculate_deltas(sympleks_tab)
    (3..9).each do |c|
      sympleks_tab[7][c] = 0.0
      sympleks_tab[8][c] = 0.0 
      sympleks_tab[9][c] = 0.0
    end

    (3..9).each do |i|
      (3..6).each do |j|
        sympleks_tab[7][i] += sympleks_tab[j][0] * sympleks_tab[j][i]
        sympleks_tab[8][i] += sympleks_tab[j][1] * sympleks_tab[j][i]
      end
      if i == 3
        sympleks_tab[7][i] += sympleks_tab[0][i]
        sympleks_tab[8][i] += sympleks_tab[1][i]
      else
        sympleks_tab[7][i] -= sympleks_tab[0][i]
        sympleks_tab[8][i] -= sympleks_tab[1][i]
      end
    end
    (3..9).each do |i|
      if i == 3
        sympleks_tab[9][i] = sympleks_tab[7][i] / sympleks_tab[8][i]
      else
        sympleks_tab[9][i] = sympleks_tab[7][3] * sympleks_tab[8][i] - (sympleks_tab[8][3] * sympleks_tab[7][i])
        #puts "i: " +i.to_s+" "+sympleks_tab[9][i].to_s+" = "+sympleks_tab[7][3].to_s+" * "+sympleks_tab[8][i].to_s+" - ("+sympleks_tab[8][3].to_s+" * "+sympleks_tab[7][i].to_s+")"
      end
    end
  end


  #index_of_min_theta_greater_than_zero   patrzymy na PION
  def self.find_exit_criteria(sympleks_tab, x)
    min = 999.0
    indexExit = nil
    (3..6).each do |j|
      if (sympleks_tab[j][3]/sympleks_tab[j][x]).abs < min && (sympleks_tab[j][3]/sympleks_tab[j][x]).abs > 0.0 && sympleks_tab[j][x] > 0.0
        min = (sympleks_tab[j][3]/sympleks_tab[j][x]).abs
        indexExit = j
      end
    end  
    indexExit
  end

  #index_of_max_delta_b_greater_than_zero   patrzymy na POZIOM
  def self.find_enter_criteria(sympleks_tab)
     max = -89
     index = nil
     (4..9).each do |i|
        if sympleks_tab[9][i] > max
          max = sympleks_tab[9][i]
          index = i
        end
      end
    raise OptymalneException if index == nil
    index
  end

  def self.transformation_to_one_in_cell(sympleks_tab)
    x = find_enter_criteria(sympleks_tab)
    y = find_exit_criteria(sympleks_tab, x)
   
    sympleks_tab[y][2] = sympleks_tab[2][x]
    sympleks_tab[y][0] = sympleks_tab[0][x]
    sympleks_tab[y][1] = sympleks_tab[1][x]

    divider=sympleks_tab[y][x]
    (3..9).each do |j|
      sympleks_tab[y][j]=sympleks_tab[y][j]/divider
    end
    {sympleks_tab: sympleks_tab, x: x, y: y}
  end

  def self.transformation_other_to_zero(sympleks_tab, x, y)
    (3..9).each do |i|
      multiplier=(sympleks_tab[i][x])*(-1)
     (3..9).each do |j|
        sympleks_tab[i][j]=sympleks_tab[i][j]+(sympleks_tab[y][j]*multiplier) if i!=y
      end
    end
    return sympleks_tab
  end

  def self.check_if_optimum(sympleks_tab)
    (4..9).each do |i|
      return false if sympleks_tab[9][i] > 0.0
      return false if sympleks_tab[8][i] > 0.0
      return false if sympleks_tab[7][i] > 0.0
    end
    true
  end
  
  def self.first_phase(sympleks_tab)
    step_by_step = []
    (0..9).each do |c|
      # binding.pry
      begin
        result = transformation_to_one_in_cell(sympleks_tab)
        x = result[:x]
        y = result[:y]
        sympleks_tab = result[:sympleks_tab]
        sympleks_tab = transformation_other_to_zero(sympleks_tab, x,y)
        calculate_deltas(sympleks_tab)
        step_by_step.push([sympleks_tab[0].clone,sympleks_tab[1].clone,sympleks_tab[2].clone,sympleks_tab[3].clone,sympleks_tab[4].clone,sympleks_tab[5].clone,sympleks_tab[6].clone,sympleks_tab[7].clone,sympleks_tab[8].clone,sympleks_tab[9].clone])
        return {sympleks_tab: sympleks_tab, step_by_step: step_by_step, success: true} if check_if_optimum(sympleks_tab)
      rescue OptymalneException
        return {sympleks_tab: sympleks_tab, step_by_step: step_by_step, success: true}
      end
    end
    {sympleks_tab: sympleks_tab, step_by_step: step_by_step, success: false}
  end

  def self.second_phase(sympleks_tab, numerator, denominator)
    change_numerator_denominator(sympleks_tab, numerator, denominator)
    calculate_deltas(sympleks_tab)
    step_by_step = []

     (0..10).each do |c|
      begin
        result = transformation_to_one_in_cell(sympleks_tab)
        x = result[:x]
        y = result[:y]
        sympleks_tab = result[:sympleks_tab]
        sympleks_tab = transformation_other_to_zero(sympleks_tab, x,y)
        calculate_deltas(sympleks_tab)

        step_by_step.push([sympleks_tab[0].clone,sympleks_tab[1].clone,sympleks_tab[2].clone,sympleks_tab[3].clone,sympleks_tab[4].clone,sympleks_tab[5].clone,sympleks_tab[6].clone,sympleks_tab[7].clone,sympleks_tab[8].clone,sympleks_tab[9].clone]) 
        return {sympleks_tab: sympleks_tab, step_by_step: step_by_step, success: true} if check_if_optimum(sympleks_tab)
      rescue OptymalneException 
        return {sympleks_tab: sympleks_tab, step_by_step: step_by_step, success: true}
      end
     end
    {sympleks_tab: sympleks_tab, step_by_step: step_by_step, success: false}
  end


  def self.change_numerator_denominator(sympleks_tab, numerator, denominator)
    (0..9).each do |c|
      sympleks_tab[0][c] = numerator[c]
      sympleks_tab[1][c] = denominator[c]
    end
    (3..9).each do |i|
      (3..6).each do |j|
        if sympleks_tab[2][i] == sympleks_tab[j][2]
          sympleks_tab[j][0] = sympleks_tab[0][i]
          sympleks_tab[j][1] = sympleks_tab[1][i]
        end
      end
    end
  end
end