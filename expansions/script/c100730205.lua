--高速决斗技能-№系猎杀
Duel.LoadScript("speed_duel_common.lua")
function c100730205.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730205.skill,c100730205.con,aux.Stringid(100730205,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730205.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsType,1-tp,LOCATION_EXTRA,0,1,nil,TYPE_XYZ)
		and Duel.GetTurnCount()>=4
end
function c100730205.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730205)
	local g=Duel.GetMatchingGroup(Card.IsType,1-tp,LOCATION_EXTRA,0,nil,TYPE_XYZ)
	local c=g:Select(tp,1,1,nil)
	if c then
		Duel.Exile(c,nil,REASON_RULE)
		local d=Duel.CreateToken(tp,8165596)
		local lp=Duel.GetLP(tp)
		Duel.SetLP(tp,lp-2700)
		Duel.SendtoDeck(d,nil,1,REASON_RULE)
		Duel.Hint(HINT_CARD,1-tp,100730205)
		e:Reset()
	end
end