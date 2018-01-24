function stripNonAlphanumeric(x)
  local y = x:gsub('%W', '')
  tex.sprint(y)
end
