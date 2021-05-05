--高速决斗技能-七皇之剑
Duel.LoadScript("speed_duel_common.lua")
function c100730110.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730110.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730110.filter(c,g)
	if not c:IsRace(RACE_FISH) then return false end
	local tc=g:GetFirst()
	while tc do
		if c:GetOriginalCode()==tc:GetOriginalCode() then
			return false
		end
		tc=g:GetNext()
	end
	g:AddCard(c)
	return true
end
function c100730110.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730110.filter,tp,LOCATION_DECK+LOCATION_HAND,0,7,nil,g) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730110,0))
		e:Reset()
		return
	end
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730110)
	local n101=Duel.CreateToken(tp,57734012)
	Duel.SendtoDeck(n101,tp,0,REASON_RULE)
	local no101=Duel.CreateToken(tp,48739166)
	Duel.SendtoDeck(no101,tp,1,REASON_RULE)
	local cno101=Duel.CreateToken(tp,12744567)
	Duel.SendtoDeck(cno101,tp,0,REASON_RULE)
	e:Reset()
end