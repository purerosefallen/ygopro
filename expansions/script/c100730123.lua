--高速决斗技能-重新开始
Duel.LoadScript("speed_duel_common.lua")
function c100730123.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730123.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730123.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	e:Reset()
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local ct=g:GetCount()
	if ct==0 then return end
	if not Duel.SelectYesNo(tp,aux.Stringid(100730123,0)) then return end
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	Duel.ShuffleDeck(tp)
	local g2=Duel.GetDecktopGroup(tp,ct)
	aux.SpeedDuelSendToHandWithExile(tp,g2)
end