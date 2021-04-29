--高速决斗技能-京塔 海滨地区
Duel.LoadScript("speed_duel_common.lua")
function c100730305.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730305.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730305.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,76806714)
	if g1:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,1-tp,100730305)
	Duel.SSet(tp,g1)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	g=g:RandomSelect(tp,1)
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	local c=Duel.CreateToken(tp,56111151)
	aux.SpeedDuelSendToHandWithExile(tp,c)
	e:Reset()
end
