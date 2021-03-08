--高速决斗技能-雷·风·水合体！
Duel.LoadScript("speed_duel_common.lua")
function c100730096.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730096.skill,c100730096.con,aux.Stringid(100730096,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730096.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,2,nil,25955164,98434877,62340868)
end
function c100730096.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730096)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,2,nil,25955164,98434877,62340868)
	local c=g:Select(tp,2,2,nil)
	if c then
		Duel.SendtoGrave(c,nil,2,REASON_RULE)
		local d=Duel.CreateToken(tp,25833572)
		Duel.MoveToField(d,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	end
end
