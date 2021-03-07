--高速决斗技能-迷宫建造
Duel.LoadScript("speed_duel_common.lua")
function c100730138.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730138.skill,c100730138.con,aux.Stringid(100730138,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730138.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,nil)
end
function c100730138.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730138)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
	local c=g:Select(tp,2,2,nil)
	if c then
		Duel.SendtoDeck(c,nil,2,REASON_RULE)
		local d=Duel.CreateToken(tp,67284908)
		Duel.MoveToField(d,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	end
end
