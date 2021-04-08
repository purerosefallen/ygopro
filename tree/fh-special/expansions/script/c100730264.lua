--高速决斗技能-梦魇音爆
Duel.LoadScript("speed_duel_common.lua")
function c100730264.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730264.skill,c100730264.con,aux.Stringid(100730264,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730264.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730264.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=4
end
function c100730264.filter(c)
	return c:IsFaceup() and c:IsCode(66516792)
end
function c100730264.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c100730264.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730264)
	Duel.ConfirmDecktop(tp,4)
	local g=Duel.GetDecktopGroup(tp,4)
	local ct=g:GetCount()
	if ct>0 and g:FilterCount(c100730264.thfilter,nil)>0 and Duel.SelectYesNo(tp,aux.Stringid(100730264,2)) then
		Duel.DisableShuffleCheck()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(tp,c100730264.thfilter,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
		ct=g:GetCount()-sg:GetCount()
		g=g-sg
	end
	if ct>0 and g:FilterCount(c100730264.thfilter,nil)>1 and Duel.SelectYesNo(tp,aux.Stringid(100730264,1)) then
		local g=Duel.GetFieldGroup(1-tp,LOCATION_ONFIELD,0)
		local c=g:Select(tp,1,1,nil)
		Duel.Destroy(c,REASON_EFFECT)
	end
	if ct>0 then
		Duel.SortDecktop(tp,tp,ct)
		for i=1,ct do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),0)
		end
	end
end