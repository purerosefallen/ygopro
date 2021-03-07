--高速决斗技能-上膛
Duel.LoadScript("speed_duel_common.lua")
function c100730121.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730121.skill,c100730121.con,aux.Stringid(100730121,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730121.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
	and aux.SpeedDuelAtMainPhaseCondition(e,tp)
	and Duel.GetTurnCount()>=5
end

function c100730121.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local ct=g:GetCount()
	if ct==0 then return end
	if not Duel.SelectYesNo(tp,aux.Stringid(100730121,0)) then return end
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	Duel.ShuffleDeck(tp)
	local g2=Duel.GetDecktopGroup(tp,ct)
	aux.SpeedDuelSendToHandWithExile(tp,g2)
	
end