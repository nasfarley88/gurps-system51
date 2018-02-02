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
