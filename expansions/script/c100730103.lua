--高速决斗技能-幻影的野兽
Duel.LoadScript("speed_duel_common.lua")
function c100730103.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730103.skill,c100730103.con,aux.Stringid(100730103,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730103.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,nil)
end
function c100730103.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730103)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_HAND,0,nil)
	local c=g:Select(tp,1,1,nil)
	if c then
		Duel.SendtoGrave(c,nil,2,REASON_RULE)
		local g1=Duel.CreateToken(tp,5818798)	
		Duel.SendtoGrave(g1,REASON_RULE)
		local g2=Duel.CreateToken(tp,77207191)
		Duel.SendtoGrave(g2,REASON_RULE)
		local d=Duel.CreateToken(tp,4796100)
		Duel.MoveToField(d,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
		d:EnableReviveLimit()
		e:Reset()
	end
end
