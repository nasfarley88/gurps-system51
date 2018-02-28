function stripNonAlphanumeric(x)
  local y = x:gsub('%W', '')
  tex.sprint(y)
end

-- From http://lua-users.org/wiki/CopyTable
function deepcopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
    copy = {}
    for orig_key, orig_value in next, orig, nil do
      copy[deepcopy(orig_key)] = deepcopy(orig_value)
    end
    setmetatable(copy, deepcopy(getmetatable(orig)))
  else -- number, string, boolean, etc
    copy = orig
  end
  return copy
end

-- innate attack function table
ia = {}

ia.setPointsPerLevel = function(innateAttack, p)
  innateAttack.pointsPerLevel = p
end

ia.setLevel = function(innateAttack, l)
  innateAttack.level = l
end

ia.createPercentModifier = function(value, reason)
  return {
    value=value,
    reason=reason
  }
end

ia.insertPercentModifier = function(innateAttack, pcmod)
  table.insert(innateAttack.percentModifiers, pcmod)
end

ia.removePercentModifier = function(innateAttack, pcmodKey)
  for i,v in ipairs(innateAttack.percentModifiers) do
    if v.reason == pcmodKey then
      table.remove(innateAttack.percentModifiers, i)
      break
    end
  end
end

-- Get points per level adjusted for % change (without rounding)
ia.getAdjustedPointsPerLevel = function(innateAttack)
  percentModifier = 1
  for i,j in pairs(innateAttack.percentModifiers) do
    percentModifier = percentModifier+j.value
  end
  return innateAttack.pointsPerLevel*percentModifier
end

-- Get total points this thing is worth (with rounding)
ia.getTotalPoints = function(innateAttack)
  return math.ceil(
    ia.getAdjustedPointsPerLevel(innateAttack)*innateAttack.level)
end


function totesseracont(n)
  n_tesseracont = {}
  if n <= 5 then
    n_tesseracont[n] = true
  elseif 5 < n  and n < 10 then
    n_tesseracont[5] = true
    n_tesseracont[n % 5] = true
  elseif 10 <= n and n < 15 then
    n_tesseracont[10] = true
    n_tesseracont[n % 10] = true
  elseif 15 <= n and n <= 20 then
    n_tesseracont[15] = true
    n_tesseracont[n % 15] = true
  elseif 20 < n and n < 25 then
    n_tesseracont[15] = true
    n_tesseracont[5] = true
    n_tesseracont[n % 20] = true
  elseif 25 <= n and n <= 30 then
    n_tesseracont[15] = true
    n_tesseracont[10] = true
    n_tesseracont[n % 25] = true
  elseif 30 < n and n <= 34 then
    n_tesseracont[15] = true
    n_tesseracont[10] = true
    n_tesseracont[5] = true
    n_tesseracont[n % 30] = true
  elseif 34 < n and n <= 37 then
    n_tesseracont[15] = true
    n_tesseracont[10] = true
    n_tesseracont[5] = true
    n_tesseracont[4] = true
    n_tesseracont[n % 34] = true
  elseif 37 < n and n <= 39 then
    n_tesseracont[15] = true
    n_tesseracont[10] = true
    n_tesseracont[5] = true
    n_tesseracont[4] = true
    n_tesseracont[3] = true
    n_tesseracont[n % 37] = true
  elseif n == 40  then
    n_tesseracont[15] = true
    n_tesseracont[10] = true
    n_tesseracont[5] = true
    n_tesseracont[4] = true
    n_tesseracont[3] = true
    n_tesseracont[2] = true
    n_tesseracont[1] = true
  end

  return n_tesseracont
end

function print_tesseracont(t)
  if t[1] then
    tex.sprint([[\one;]])
  end
  if t[2] then
    tex.sprint([[\two;]])
  end
  if t[3] then
    tex.sprint([[\three;]])
  end
  if t[4] then
    tex.sprint([[\four;]])
  end
  if t[5] then
    tex.sprint([[\five;]])
  end
  if t[10] then
    tex.sprint([[\ten;]])
  end
  if t[15] then
    tex.sprint([[\fifteen;]])
  end
end
