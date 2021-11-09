--高速决斗技能-№系回复
Duel.LoadScript("speed_duel_common.lua")
function c100730210.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730210.skill,c100730210.con,aux.Stringid(100730210,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730210.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(c100730210.rmfilter,tp,LOCATION_MZONE,0,1,nil) 
end
function c100730210.skill(e,tp,eg,ep,ev,re,r,rp)	
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730210)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.GetMatchingGroup(c100730210.rmfilter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	local no=tc.xyz_number
	Duel.Recover(tp,no*20,REASON_EFFECT)
end
function c100730210.rmfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x48)
end