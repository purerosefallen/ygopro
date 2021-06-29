--高速决斗技能-№系猎杀
Duel.LoadScript("speed_duel_common.lua")
function c100730126.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730126.skill,c100730126.con,aux.Stringid(100730126,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730126.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(c100730126.rmfilter,tp,0,LOCATION_EXTRA,1,nil) 
		and Duel.GetTurnCount()>=4
end
function c100730126.skill(e,tp,eg,ep,ev,re,r,rp)	
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730126)
	local g=Duel.GetMatchingGroup(c100730126.rmfilter,tp,0,LOCATION_EXTRA,nil)
	if g:GetCount()==0 then return end
	local tc=g:RandomSelect(tp,1):GetFirst()
	Duel.Remove(tc,POS_FACEUP,REASON_RULE)
	local no=tc.xyz_number
	Duel.Damage(tp,no*30,REASON_EFFECT)
	local code=tc:GetCode()
	Duel.Exile(tc,REASON_RULE)
	local c=Duel.CreateToken(tp,code)
	Duel.SendtoDeck(c,nil,0,REASON_RULE)
end
function c100730126.rmfilter(c)
	return c:IsFacedown() and c:IsAbleToRemove()
end