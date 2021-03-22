--高速决斗技能-作弊洗牌术
Duel.LoadScript("speed_duel_common.lua")
function c100730183.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730183.skill,c100730183.con,aux.Stringid(100730183,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730183.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
end


function c100730183.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730183,0)) then	
		Duel.PayLPCost(tp,300)
		Duel.Hint(HINT_CARD,1-tp,100730183)
		local op=Duel.SelectOption(tp,aux.Stringid(100730183,1),aux.Stringid(100730183,2))
		if op==0 then		  
			Duel.ShuffleDeck(1-tp)
			local g=Duel.GetMatchingGroup(Card.IsLevelBelow,1-tp,LOCATION_DECK,0,nil,3)
			if not g or g:GetCount()==0 then return end
			g=g:RandomSelect(tp,1)
			Duel.MoveSequence(g:GetFirst(),0)
		else
			Duel.ShuffleDeck(tp)
			local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_CONTINUOUS)
			if not g or g:GetCount()==0 then return end
			g=g:RandomSelect(tp,1)
			Duel.MoveSequence(g:GetFirst(),0)
		end
	end
end
