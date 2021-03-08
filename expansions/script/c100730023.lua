--高速决斗技能-生命增加γ
Duel.LoadScript("speed_duel_common.lua")
function c100730023.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730023.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730023.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp+4000)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	g=g:RandomSelect(tp,2)
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	e:Reset()
end