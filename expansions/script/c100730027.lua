--高速决斗技能-生命增加α
Duel.LoadScript("speed_duel_common.lua")
function c100730027.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730027.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730027.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730027)
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp+3500)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
	local c=g:Select(tp,1,1,nil)
	Duel.SendtoDeck(c,nil,1,REASON_RULE)
	local d=Duel.CreateToken(tp,20871001)
	aux.SpeedDuelSendToHandWithExile(tp,d)
	e:Reset()
end