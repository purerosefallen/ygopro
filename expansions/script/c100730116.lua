--高速决斗技能-皇家同花顺
Duel.LoadScript("speed_duel_common.lua")
function c100730116.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730116.skill,c100730116.con,aux.Stringid(100730106,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730116.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,64788463)
end
function c100730116.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,1,nil,64788463)
	local c=g:Select(tp,1,1,nil)
	if c then
		Duel.Hint(HINT_CARD,1-tp,100730116)
		local lp=Duel.GetLP(tp)
		Duel.SetLP(tp,lp-1000)
		local d=Duel.CreateToken(tp,25652259)
		Duel.MoveToField(d,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	e:Reset()
	end
end