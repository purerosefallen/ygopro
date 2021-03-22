--高速决斗技能-生命增加Ω
Duel.LoadScript("speed_duel_common.lua")
function c100730024.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730024.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730024.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730024)
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp+7500)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	g=g:RandomSelect(tp,3)
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	e:Reset()
end