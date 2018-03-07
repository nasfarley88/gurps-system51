function getjsonfile(file)
  local f, s
  f = io.open(file, 'r')
  s = f:read('*a')
  f.close()
  return s
end

_GNPC_NAMES =  utilities.json.tolua(getjsonfile('npc-names.json'))

function is_male_name(name_obj)
  return table.contains(name_obj.genders, "male")
end

function is_female_name(name_obj)
  return table.contains(name_obj.genders, "female")
end

function male_andor_female(name_obj)
  if is_male_name(name_obj) and is_female_name(name_obj) then
    return "♂♀"
  elseif is_male_name(name_obj) then
    return "♂"
  elseif is_female_name(name_obj) then
    return "♀"
  end
end

function rep_npc_name(name_obj)
  return name_obj.name .. male_andor_female(name_obj)
end

function get_random_name(predicate)
  -- Try max 30 times
  for i=1,30 do
    local randint = math.random(#_GNPC_NAMES)
    if predicate(_GNPC_NAMES[randint]) then
      return _GNPC_NAMES[randint]
    end
  end
end

function get_random_male_name()
  return get_random_name(is_male_name)
end

function get_random_male_only_name()
  return get_random_name(function(x)
      return is_male_name(x) and not is_female_name(x)
  end)
end

function get_random_female_name()
  return get_random_name(is_female_name)
end

function print_npc_name_list()
  local s = [[\begin{itemize}]]
  for i=1,30 do
    local male_name_obj = nil
    local female_name_obj = get_random_female_name()
    if not is_male_name(female_name_obj) then
      male_name_obj = get_random_male_only_name()
    end
    s = s .. [[\item ]]
    s = s .. rep_npc_name(female_name_obj)
    if male_name_obj then
      s = s .. "/" .. rep_npc_name(male_name_obj)
    end
    s = s .. [[\dotfill Demeanor \dotfill Notes \dotfill]]
    s = s .. "\n"
  end
  s = s .. [[\end{itemize}]]
  tex.print(s)
end
