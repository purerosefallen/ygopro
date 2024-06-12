--高速决斗技能-生命增加Ω
Duel.LoadScript("speed_duel_common.lua")
function c100730025.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730025.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730025.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730025)
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp+10000)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	g=g:RandomSelect(tp,4)
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	e:Reset()
end